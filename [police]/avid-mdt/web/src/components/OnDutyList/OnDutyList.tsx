import React, { useState, useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';

import OnDutyCard from '@/components/OnDutyCard';
import Loader from '@/components/Loader';

import './OnDutyList.scss';

const OnDutyList = () => {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { onDutyList, isFetchedOnDutyList } = useSelector((state: RootState) => state.globalSlice);

  useEffect(() => {
    setIsLoading(false);
  }, [onDutyList]);

  return (
    <section className="on-duty-list">
      <div className="on-duty-list__header">
        <div className="section-line section-line--yellow"></div>

        <h3 className="section-title">
          <span className="text-extrabold">On</span> Duty List (Officer Infos)
        </h3>
      </div>

      <div className="on-duty-list__main">
        {isLoading && isFetchedOnDutyList === 0 ? (
          <Loader />
        ) : (
          <>
            {onDutyList.length > 0 ? (
              <>
                {onDutyList.map((duty) => (
                  <OnDutyCard key={duty.id} data={duty} />
                ))}
              </>
            ) : (
              <span className="section-text">Active cops is not found.</span>
            )}
          </>
        )}
      </div>
    </section>
  );
};

export default OnDutyList;
