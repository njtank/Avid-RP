import React, { FC, useState, useEffect } from 'react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setCameras, setIsFetchedCameras } from '@/slices/camerasSlice';
import { fetchNui } from '@/utils/fetchNui';
import { successNotify, errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import './CamerasCard.scss';

interface ICamerasCardProps {
  data: {
    id: any;
    image: string;
    title: string;
  };
}

const CamerasCard: FC<ICamerasCardProps> = ({ data }) => {
  const { id, image, title } = data;

  const handleOpenCamera = (id: number) => {
    fetchNui('openCamera', { id })
      .then((res) => {
        if (res.success) {
          successNotify(`${title} is successfully opened.}`);
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          successNotify(`${title} is successfully opened.`);
        } else {
          errorNotify('Error occurred while opened the camera.');
        }
      });
  };

  return (
    <div onClick={() => handleOpenCamera(id)} className="cameras-card">
      <div className="cameras-card__header">
        <img src={image} alt="" className="cameras-card__img" />
      </div>

      <div className="cameras-card__body">
        <span className="cameras-card__title">{title}</span>
      </div>
    </div>
  );
};

export default CamerasCard;
