import React, { useState, useEffect } from 'react';
import { X } from '@phosphor-icons/react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setEditedFineId } from '@/slices/globalSlice';
import { editFines, setIsActiveEditingDeleted } from '@/slices/finesSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import Input from '@/components/Input';
import NumericInput from '@/components/NumericInput';
import Select from '@/components/Select';
import Button from '@/components/Button';
import Loader from '@/components/Loader';
import StatusInfo from '@/components/StatusInfo';

import './EditFines.scss';

const jailTimeType = [
  {
    id: 'days',
    value: 'Days',
    name: 'Days',
  },
  {
    id: 'weeks',
    value: 'Weeks',
    name: 'Weeks',
  },
  {
    id: 'months',
    value: 'Months',
    name: 'Months',
  },
  {
    id: 'years',
    value: 'Years',
    name: 'Years',
  },
];

const EditFines = () => {
  const [editedFineData, setEditedFineData] = useState({
    name: '',
    jailTime: '',
    jailTimeType: '',
    money: '',
    lastEdited: '',
  });
  const [formData, setFormData] = useState({ name: '', jailTime: '', jailTimeType: '', money: '' });
  const [nameError, setNameError] = useState<string>('');
  const [jailTimeError, setJailTimeError] = useState<string>('');
  const [moneyError, setMoneyError] = useState<string>('');
  const [isDuplicate, setIsDuplicate] = useState<number>(0);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { fines, isActiveEditingDeleted } = useSelector((state: RootState) => state.finesSlice);
  const { editedFineId, info, permissions } = useSelector((state: RootState) => state.globalSlice);
  const { policeRank } = info;
  const dispatch = useDispatch();

  const timeAgo = (current: number) => {
    const time = Math.floor((Date.now() - current * 1000) / 1000);
    if (time < 60) {
      return `${time} seconds`;
    } else if (time >= 60 && time < 3600) {
      return `${Math.floor(time / 60)} minutes`;
    } else if (time >= 3600 && time < 86400) {
      return `${Math.floor(time / 3600)} hours`;
    } else if (time >= 86400) {
      return `${Math.floor(time / 86400)} days`;
    }
  };

  const handleOnSubmit = (e: any) => {
    e.preventDefault();

    setIsDuplicate((current) => (current += 1));

    if (isDuplicate > 1) return false;

    if (formData.name.length < 1) {
      setNameError('Fines name field is required.');
    } else {
      setNameError('');
    }

    if (formData.jailTime.length < 1 || formData.jailTimeType.length < 1) {
      setJailTimeError('Jail time and jail time type field is required.');
    } else {
      setJailTimeError('');
    }

    if (formData.money.length < 1) {
      setMoneyError('Money field is required.');
    } else {
      setMoneyError('');
    }

    if (
      formData.name.length > 0 &&
      formData.jailTime.length > 0 &&
      formData.jailTimeType.length > 0 &&
      formData.money.length > 0
    ) {
      fetchNui('editFine', {
        id: editedFineId,
        name: formData.name,
        jailTime: formData.jailTime,
        jailTimeType: formData.jailTimeType,
        money: formData.money,
      })
        .then((res) => {
          if (res.success) {
            fines.map((fine) => {
              if (fine.id === editedFineId) {
                dispatch(
                  editFines({
                    id: editedFineId,
                    name: formData.name,
                    jailTime: formData.jailTime,
                    jailTimeType: formData.jailTimeType,
                    money: formData.money,
                    addedBy: res.data.addedBy,
                  }),
                );
                setEditedFineData({
                  name: formData.name,
                  jailTime: formData.jailTime,
                  jailTimeType: formData.jailTimeType,
                  money: formData.money,
                  lastEdited: `Last edited ${timeAgo(res.data.lastEdited.time)} ago by ${
                    res.data.lastEdited.editedBy
                  }`,
                });
                successNotify('Fine is succesfully edited.');
              }
            });
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            fines.map((fine) => {
              if (fine.id === editedFineId) {
                dispatch(
                  editFines({
                    id: editedFineId,
                    name: formData.name,
                    jailTime: `${formData.jailTime} ${formData.jailTimeType}`,
                    jailTimeType: formData.jailTimeType,
                    money: formData.money,
                    addedBy: 'Yordi',
                  }),
                );
                setEditedFineData({
                  name: formData.name,
                  jailTime: formData.jailTime,
                  jailTimeType: formData.jailTimeType,
                  money: formData.money,
                  lastEdited: 'Last edited 1 hours ago by Yordi',
                });
                successNotify('Fine is succesfully edited.');
              }
            });
          } else {
            errorNotify('Error occurred while edited fine.');
          }
        });
    }
  };

  const handleChange = (e: any) => {
    const { name, value } = e.target;
    setFormData((current) => ({ ...current, [name]: value }));
  };

  useEffect(() => {
    fines.map((fine) => {
      if (fine.id === editedFineId) {
        const formattedJailTime = fine.fields[1].text
          .replace('Days', '')
          .replace('Weeks', '')
          .replace('Months', '')
          .replace('Years', '')
          .trim();

        setEditedFineData({
          name: fine.fields[0].text,
          jailTime: formattedJailTime,
          jailTimeType: fine.jailTimeType,
          money: fine.fields[2].text,
          lastEdited: fine.lastEdited,
        });
        setFormData({
          name: fine.fields[0].text,
          jailTime: formattedJailTime,
          jailTimeType: fine.jailTimeType,
          money: fine.fields[2].text,
        });

        setTimeout(() => {
          setIsLoading(false);
        }, 300);
      }
    });

    return () => {
      setEditedFineData({ name: '', jailTime: '', jailTimeType: '', money: '', lastEdited: '' });
      setFormData({ name: '', jailTime: '', jailTimeType: '', money: '' });
      setIsDuplicate(0);
      setIsLoading(true);
      dispatch(setIsActiveEditingDeleted(false));
    };
  }, [editedFineId]);

  useEffect(() => {
    if (!isActiveEditingDeleted) return;

    dispatch(setEditedFineId(0));
  }, [isActiveEditingDeleted]);

  return (
    <section className="edit-fines">
      <div className="edit-fines__header">
        <div className="section-line section-line--blue"></div>

        <h3 className="section-title">
          <span className="text-extrabold">Edit</span> Fines
        </h3>
      </div>

      <div className="edit-fines__main">
        {!permissions.editFines.includes(policeRank) ? (
          <StatusInfo
            status="lock"
            text="Make sure your rank is sufficient to access this edit and add tab."
          />
        ) : (
          <>
            {isLoading ? (
              <Loader />
            ) : (
              <>
                <div className="row g-4 mb-4">
                  <div className="col-lg-9">
                    <span className="edit-fines__title">{editedFineData.name}</span>
                    <p className="edit-fines__text">{editedFineData.lastEdited}</p>
                  </div>

                  <div className="col-lg-3 d-flex justify-content-end">
                    <div onClick={() => dispatch(setEditedFineId(0))} className="edit-fines__close">
                      <X />
                    </div>
                  </div>
                </div>

                <form className="form" onSubmit={handleOnSubmit}>
                  <div className="form__group">
                    <label htmlFor="name" className="form__label">
                      Fines Name
                    </label>
                    <Input
                      onChange={handleChange}
                      iStyle="two"
                      id="name"
                      name="name"
                      value={editedFineData.name}
                    />
                    {nameError && (
                      <span className="modal__help-message modal__help-message--error">
                        {nameError}
                      </span>
                    )}
                  </div>

                  <div className="form__group">
                    <label htmlFor="jailTime" className="form__label">
                      Fines Jail Time
                    </label>
                    <div className="d-flex align-items-center">
                      <Input
                        onChange={handleChange}
                        iStyle="two"
                        id="jailTime"
                        name="jailTime"
                        type="number"
                        value={editedFineData.jailTime}
                        className="w-100 me-3"
                      />
                      <Select
                        onChange={handleChange}
                        options={jailTimeType}
                        defaultValue={editedFineData.jailTimeType}
                        id="jailTimeType"
                        name="jailTimeType"
                        styleType="two"
                      />
                    </div>
                    {jailTimeError && (
                      <span className="modal__help-message modal__help-message--error">
                        {jailTimeError}
                      </span>
                    )}
                  </div>

                  <div className="form__group">
                    <label htmlFor="money" className="form__label">
                      Fines Money
                    </label>
                    <NumericInput
                      onChange={handleChange}
                      iStyle="two"
                      id="money"
                      name="money"
                      value={editedFineData.money}
                    />
                    {moneyError && (
                      <span className="modal__help-message modal__help-message--error">
                        {moneyError}
                      </span>
                    )}
                  </div>

                  {isDuplicate > 2 && (
                    <span className="modal__help-message modal__help-message--error">
                      You{"'"}re submiting so many to form. Please take a break.
                    </span>
                  )}

                  <div className="form__group mt-4">
                    <Button theme="blue" size="big" type="submit">
                      Save Changes
                    </Button>
                  </div>
                </form>
              </>
            )}
          </>
        )}
      </div>
    </section>
  );
};

export default EditFines;
