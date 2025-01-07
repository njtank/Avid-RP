import React from 'react';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';

import Map from '@/components/Map';
import './LiveMap.scss';

const LiveMap = () => {
  const { activePolices, dispatchs } = useSelector((state: RootState) => state.liveMapSlice);

  return (
    <>
      <section className="live-map">
        <div className="live-map__header">
          <div className="section-line section-line--blue"></div>

          <h3 className="section-title">
            <span className="text-extrabold">Live</span> Map
          </h3>
        </div>

        <div className="live-map__main">
          <div className="live-map__inner">
            <Map markers={activePolices} dispatchs={dispatchs} />
          </div>
        </div>
      </section>
    </>
  );
};

export default LiveMap;
