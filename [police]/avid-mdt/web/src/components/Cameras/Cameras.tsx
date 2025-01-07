import React, { useState, useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector } from 'react-redux';

import CamerasCard from '@/components/CamerasCard';
import Loader from '@/components/Loader';

import './Cameras.scss';

const Cameras = () => {
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { cameras, isFetchedCameras } = useSelector((state: RootState) => state.camerasSlice);

  useEffect(() => {
    setIsLoading(false);
  }, [cameras]);

  return (
    <section className="cameras">
      <div className="cameras__header">
        <div className="section-line section-line--blue"></div>

        <h3 className="section-title">
          <span className="text-extrabold">Cameras</span> List
        </h3>
      </div>

      <div className="cameras__main">
        {isLoading && isFetchedCameras === 0 ? (
          <Loader />
        ) : (
          <div className="row g-4">
            {cameras.length > 0 &&
              cameras.map((camera) => (
                <div key={camera.id} className="col-md-12 col-lg-4 col-xl-3">
                  <CamerasCard data={camera} />
                </div>
              ))}
          </div>
        )}
      </div>
    </section>
  );
};

export default Cameras;
