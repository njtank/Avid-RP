import React, { useState, useEffect } from 'react';
import { Warning, UsersThree, MapPin } from '@phosphor-icons/react';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import Textarea from '@/components/Textarea';
import Loader from '@/components/Loader';
import HelpMessage from '@/components/HelpMessage';

import departmentImage from '@/assets/images/department-image.png';
import './DepartmentDetail.scss';

const DepartmentDetail = () => {
  const { department, isFetchedDepartment } = useSelector(
    (state: RootState) => state.departmentSlice,
  );
  const { image, name, totalBans, totalPersonal, location, description } = department;
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [formDescription, setFormDescription] = useState<string>('');
  const [isDuplicate, setIsDuplicate] = useState<number>(0);

  const handleSubmitDescription = () => {
    setIsDuplicate((current: any) => (current += 1));

    if (isDuplicate > 1) return;

    fetchNui('editDescriptionOfDepartment', {
      description: formDescription,
    })
      .then((res) => {
        if (res.success) {
          successNotify('Description is successfully updated.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          successNotify('Description is successfully updated.');
        } else {
          errorNotify('Error occurred while updated description.');
        }
      });
  };

  useEffect(() => {
    setIsLoading(false);
    setFormDescription(description);
  }, [department]);

  return (
    <section className="department-detail">
      <div className="department-detail__header">
        <div className="section-line section-line--blue"></div>

        <h3 className="section-title text-extrabold">Department</h3>
      </div>

      <div className="department-detail__main">
        {isLoading && isFetchedDepartment === 0 ? (
          <Loader />
        ) : (
          <>
            <div className="department-detail__image-container mb-4">
              <img src={image || departmentImage} alt="" className="department-detail__img" />

              <div className="department-detail__name">{name}</div>
            </div>

            <div className="d-flex flex-column mb-4">
              <div className="d-flex align-items-center mb-15">
                <div className="section-square section-square--blue"></div>
                <span className="section-title section-title--medium text-bold">
                  Department Info
                </span>
              </div>

              <div className="row g-2">
                <div className="col-lg-6">
                  <div className="department-detail__item">
                    <div className="department-detail__icon">
                      <Warning weight="fill" />
                    </div>

                    <div className="department-detail__item-inner">
                      <p className="department-detail__text">
                        Total Bans:{' '}
                        <span className="department-detail__text text-bold">{totalBans}</span>
                      </p>
                    </div>
                  </div>
                </div>

                <div className="col-lg-6">
                  <div className="department-detail__item">
                    <div className="department-detail__icon">
                      <UsersThree weight="fill" />
                    </div>

                    <div className="department-detail__item-inner">
                      <p className="department-detail__text">
                        Total Personal:{' '}
                        <span className="department-detail__text text-bold">{totalPersonal}</span>
                      </p>
                    </div>
                  </div>
                </div>

                <div className="col-lg-12">
                  <div className="department-detail__item">
                    <div className="department-detail__icon">
                      <MapPin weight="fill" />
                    </div>

                    <div className="department-detail__item-inner">
                      <p className="department-detail__text">
                        Location:{' '}
                        <span className="department-detail__text text-bold">{location}</span>
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div className="d-flex flex-column">
              <div className="d-flex align-items-center mb-15">
                <div className="section-square section-square--blue"></div>
                <span className="section-title section-title--medium text-bold">
                  Department Description
                </span>
              </div>

              <Textarea
                value={formDescription}
                setValue={setFormDescription}
                onSubmit={handleSubmitDescription}
              />
              {isDuplicate > 2 && (
                <HelpMessage status="error">
                  You{"'"}re updating so fast, please take a break.
                </HelpMessage>
              )}
            </div>
          </>
        )}
      </div>
    </section>
  );
};

export default DepartmentDetail;
