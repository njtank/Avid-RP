import React, { useState, useEffect } from 'react';
import { X } from '@phosphor-icons/react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setEditedWantedId } from '@/slices/globalSlice';
import {
  setWantedDetail,
  deleteRankFromWantedDetail,
  deleteEvidenceFromWantedDetail,
  setIsActiveEditingDeleted,
} from '@/slices/wantedsSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import FoundEvidences from '@/components/FoundEvidences';
import Ranks from '@/components/Ranks';
import Textarea from '@/components/Textarea';
import Loader from '@/components/Loader';
import HelpMessage from '@/components/HelpMessage';
import Label from '@/components/Label';

import profileImage from '@/assets/images/recording-details-profile-image.png';
import evidenceExampleImage from '@/assets/images/evidence-example-image.webp';
import './WantedDetail.scss';

const WantedDetail = () => {
  const editedWantedId = useSelector((state: RootState) => state.globalSlice.editedWantedId);
  const { wantedDetail, isActiveEditingDeleted } = useSelector(
    (state: RootState) => state.wantedsSlice,
  );
  const [formReportText, setFormReportText] = useState<string>('');
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [isDuplicate, setIsDuplicate] = useState<number>(0);
  const { id, avatar, name, madeBy, ranks, reportText, evidences, type } = wantedDetail;
  const dispatch = useDispatch();

  const handleDeleteRank = (id: number) => {
    fetchNui('deleteRankFromWanted', {
      id,
      wantedId: editedWantedId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteRankFromWantedDetail(id));
          successNotify('Rank is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteRankFromWantedDetail(id));
          successNotify('Rank is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted rank.');
        }
      });
  };

  const handleDeleteEvidence = (id: number) => {
    fetchNui('deleteEvidenceFromWanted', {
      id,
      wantedId: editedWantedId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteEvidenceFromWantedDetail(id));
          successNotify('Rank is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteEvidenceFromWantedDetail(id));
          successNotify('Evidence is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted evidence.');
        }
      });
  };

  const handleSubmitReportText = () => {
    setIsDuplicate((current: any) => (current += 1));

    if (isDuplicate > 1) return;

    fetchNui('editReportTextFromWanted', {
      id: editedWantedId,
      reportText: formReportText,
    })
      .then((res) => {
        if (res.success) {
          successNotify('Report text is succesfully updated.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          successNotify('Report text is succesfully updated.');
        } else {
          errorNotify('Error occurred while updated report text.');
        }
      });
  };

  useEffect(() => {
    fetchNui('getWantedDetail', {
      id: editedWantedId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(setWantedDetail(res.data));
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(
            setWantedDetail({
              id: 0,
              avatar: profileImage,
              name: 'Yordi',
              madeBy: 'Yordi',
              type: 'user',
              ranks: [
                {
                  id: 1,
                  name: 'Suspect',
                },
                {
                  id: 2,
                  name: 'Murderer',
                },
              ],
              reportText: 'test',
              evidences: [
                {
                  id: 1,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
                {
                  id: 2,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
                {
                  id: 3,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
              ],
            }),
          );
        } else {
          errorNotify('Error occurred while fetched data.');
        }
      });
  }, [editedWantedId]);

  useEffect(() => {
    setTimeout(() => {
      setIsLoading(false);
      setFormReportText(reportText);
    }, 300);
  }, [wantedDetail]);

  useEffect(() => {
    return () => {
      setIsLoading(true);
      dispatch(setIsActiveEditingDeleted(false));
    };
  }, [editedWantedId]);

  useEffect(() => {
    if (!isActiveEditingDeleted) return;

    dispatch(setEditedWantedId(0));
  }, [isActiveEditingDeleted]);

  return (
    <section className="wanted-detail">
      <div className="wanted-detail__header">
        <div className="section-line section-line--blue"></div>

        <h3 className="section-title">
          <span className="text-extrabold">Wanted</span> Detail
        </h3>
      </div>

      <div className="wanted-detail__main">
        {isLoading ? (
          <Loader />
        ) : (
          <>
            <div className="position-relative">
              <div onClick={() => dispatch(setEditedWantedId(0))} className="wanted-detail__close">
                <X />
              </div>
            </div>

            <div className="d-flex">
              <div className="wanted-detail__avatar mr-15">
                <img src={avatar} alt="" className="wanted-detail__avatar-img" />
              </div>

              <div className="d-flex flex-column">
                <div className="d-flex align-items-center">
                  <span className="wanted-detail__title">{name}</span>
                  {type === 'user' && (
                    <Label theme="blue" className="ms-2">
                      User
                    </Label>
                  )}
                  {type === 'vehicle' && (
                    <Label theme="orange" className="ms-2">
                      Vehicle
                    </Label>
                  )}
                </div>

                <p className="wanted-detail__text">#{id}</p>

                {type === 'user' && (
                  <Ranks
                    data={ranks}
                    handleRemove={handleDeleteRank}
                    addWhere="wanted-detail"
                    className="mt-1"
                  />
                )}

                <span className="wanted-detail__by-made mt-2">
                  This process made by <span className="text-extrabold">{madeBy}</span>.
                </span>
              </div>
            </div>

            <div className="wanted-detail__hr"></div>

            <div className="d-flex flex-column mb-4">
              <div className="d-flex align-items-center mb-15">
                <div className="section-square section-square--blue"></div>
                <span className="section-title section-title--medium text-bold">
                  Minutes Reports
                </span>
              </div>

              <Textarea
                value={formReportText}
                setValue={setFormReportText}
                onSubmit={handleSubmitReportText}
              />
              {isDuplicate > 2 && (
                <HelpMessage status="error">
                  You{"'"}re updating so fast, please take a break.
                </HelpMessage>
              )}
            </div>

            <FoundEvidences
              data={evidences}
              handleRemove={handleDeleteEvidence}
              addWhere="wanted-detail"
            />
          </>
        )}
      </div>
    </section>
  );
};

export default WantedDetail;
