import React, { useState, useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';

import HotWantedCard from '@/components/HotWantedCard';
import Loader from '@/components/Loader';

import './HotWantedList.scss';

const HotWantedList = () => {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { hotWantedList, isFetchedHotWantedList } = useSelector(
    (state: RootState) => state.globalSlice,
  );

  useEffect(() => {
    setIsLoading(true);
  }, [hotWantedList]);

  return (
    <section className="hot-wanted-list">
      <div className="hot-wanted-list__header">
        <div className="section-line section-line--red"></div>

        <h3 className="section-title">
          <span className="text-extrabold">Hot</span> Wanted List
        </h3>
      </div>

      <div className="hot-wanted-list__main">
        {isLoading && isFetchedHotWantedList === 0 ? (
          <Loader />
        ) : (
          <>
            {hotWantedList.length > 0 ? (
              <>
                {hotWantedList
                  .slice()
                  .reverse()
                  .map((wanted, index) => (
                    <HotWantedCard data={wanted} key={index} />
                  ))}
              </>
            ) : (
              <span className="section-text">Hot wanted suspects is not found.</span>
            )}
          </>
        )}
      </div>
    </section>
  );
};

export default HotWantedList;
