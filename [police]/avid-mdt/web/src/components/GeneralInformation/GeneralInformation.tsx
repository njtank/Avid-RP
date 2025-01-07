import React, { FC, useState, useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';
import cx from 'classnames';

import Loader from '@/components/Loader';

import recordsDarkBlueIcon from '@/assets/icons/records-dark-blue.svg';
import wantedDarkBlueIcon from '@/assets/icons/wanted-dark-blue.svg';
import './GeneralInformation.scss';

interface IGeneralInformationProps {
  className?: string;
}

const GeneralInformation: FC<IGeneralInformationProps> = ({ className }) => {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { info } = useSelector((state: RootState) => state.globalSlice);
  const { dailyRecordsCount, dailyWantedsCount, totalRecordsCount, totalWantedsCount } = info;

  useEffect(() => {
    setIsLoading(false);
  }, [info]);

  return (
    <section className={cx('general-information', className)}>
      <div className="general-information__header">
        <div className="section-line section-line--blue"></div>

        <h3 className="section-title">
          <span className="text-extrabold">General</span> Information
        </h3>
      </div>

      <div className="general-information__main">
        {isLoading ? (
          <Loader />
        ) : (
          <div className="row g-3">
            <div className="col-md-12 col-lg-6 col-xl-6">
              <div className="general-information__item">
                <div className="general-information__icon general-information__icon--purple">
                  <img src={recordsDarkBlueIcon} alt="" className="general-information__icon-img" />
                </div>

                <div className="d-flex flex-column">
                  <span className="general-information__title">Daily Records</span>
                  <p className="general-information__text">{dailyRecordsCount}</p>
                </div>
              </div>

              <div className="d-flex flex-column mt-4">
                <div
                  className="general-information__progress-line general-information__progress-line--purple"
                  style={{ '--value': '55%' } as React.CSSProperties}
                ></div>

                <p className="general-information__title d-flex align-items-center">
                  Total Records
                  <span className="general-information__text general-information__text--medium ms-1">
                    {totalRecordsCount}
                  </span>
                </p>
              </div>
            </div>

            <div className="col-md-12 col-lg-6 col-xl-6">
              <div className="general-information__item">
                <div className="general-information__icon general-information__icon--cream">
                  <img src={wantedDarkBlueIcon} alt="" className="general-information__icon-img" />
                </div>

                <div className="d-flex flex-column">
                  <span className="general-information__title">Daily Wanteds</span>
                  <p className="general-information__text">{dailyWantedsCount}</p>
                </div>
              </div>

              <div className="d-flex flex-column align-items-md-start align-items-lg-end mt-4">
                <div
                  className="general-information__progress-line general-information__progress-line--cream"
                  style={{ '--value': '25%' } as React.CSSProperties}
                ></div>

                <p className="general-information__title d-flex align-items-center text-right">
                  <span className="general-information__text general-information__text--medium me-1">
                    {totalWantedsCount}
                  </span>
                  Total Wanteds
                </p>
              </div>
            </div>
          </div>
        )}
      </div>
    </section>
  );
};

export default GeneralInformation;
