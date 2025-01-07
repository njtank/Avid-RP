import React, { FC, useState, useEffect } from 'react';
import { Plus, NotePencil, X } from '@phosphor-icons/react';
import { useDispatch } from 'react-redux';
import { setActiveModal, setImageModalData } from '@/slices/globalSlice';
import cx from 'classnames';

import AddEvidenceModal from '@/modals/AddEvidenceModal';
import ImageModal from '@/components/ImageModal';

import './FoundEvidences.scss';

type dataType = {
  id: number;
  image: string;
  name: string;
};

interface IFoundEvidencesProps {
  data: dataType[];
  handleRemove?: any;
  addWhere: string;
}

const FoundEvidences: FC<IFoundEvidencesProps> = ({ data, handleRemove, addWhere }) => {
  const [isEditable, setIsEditable] = useState<boolean>(false);
  const dispatch = useDispatch();

  const toggleEditable = () => {
    setIsEditable((current) => !current);
  };

  const handleOpenImageModal = (data: any) => {
    if (!isEditable) {
      dispatch(
        setImageModalData({
          active: true,
          image: data.image,
          title: data.name,
        }),
      );
    }
  };

  return (
    <>
      <AddEvidenceModal addWhere={addWhere} />
      <ImageModal />

      <div className="found-evidences">
        <div className="found-evidences__header">
          <div className="d-flex align-items-center">
            <div className="section-square section-square--blue"></div>
            <span className="section-title section-title--medium text-bold">Found Evidences</span>
          </div>

          <div className="found-evidences__action">
            <div
              onClick={() => dispatch(setActiveModal('add-evidence'))}
              className="found-evidences__action-item"
            >
              <Plus />
            </div>

            {data.length > 0 && (
              <div
                onClick={toggleEditable}
                className="found-evidences__action-item found-evidences__action-item--edit"
              >
                <NotePencil />
              </div>
            )}
          </div>
        </div>

        {data.length > 0 ? (
          <div className="row g-3">
            {data.map((item) => (
              <div key={item.id} className="col-lg-6">
                <div
                  onClick={() => handleOpenImageModal(item)}
                  className={cx('found-evidences__item', {
                    'found-evidences__item--link': !isEditable,
                  })}
                >
                  <div className="found-evidences__image-container mr-15">
                    <img src={item.image} alt="" className="found-evidences__image" />
                  </div>

                  <div className="d-flex justify-content-between align-items-center w-100">
                    <span className="found-evidences__text">{item.name}</span>

                    {isEditable && (
                      <div
                        onClick={() => handleRemove(item.id)}
                        className="found-evidences__delete"
                      >
                        <X weight="bold" />
                      </div>
                    )}
                  </div>
                </div>
              </div>
            ))}
          </div>
        ) : (
          <span className="section-text">Evidences is not found.</span>
        )}
      </div>
    </>
  );
};

export default FoundEvidences;
