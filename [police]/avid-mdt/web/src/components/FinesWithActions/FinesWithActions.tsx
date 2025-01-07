import React, { FC, useState, useEffect } from 'react';
import { Plus, NotePencil, X } from '@phosphor-icons/react';
import { useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';
import cx from 'classnames';

import AddFinesWithActionsModal from '@/modals/AddFinesWithActionsModal';

import './FinesWithActions.scss';

type dataType = {
  id: number;
  name: string;
};

interface IFinesWithActionsProps {
  data: dataType[];
  handleRemove?: any;
  addWhere: string;
  className?: string;
}

const FinesWithActions: FC<IFinesWithActionsProps> = ({
  data,
  handleRemove,
  addWhere,
  className,
}) => {
  const [isEditable, setIsEditable] = useState<boolean>(false);
  const dispatch = useDispatch();

  const toggleEditable = () => {
    setIsEditable((current) => !current);
  };
  return (
    <>
      <AddFinesWithActionsModal addWhere={addWhere} />

      <div className={cx('fines-with-actions', className)}>
        <div className="fines-with-actions__header">
          <div className="d-flex align-items-center">
            <div className="section-square section-square--blue"></div>
            <span className="section-title section-title--medium text-bold">Fines</span>
          </div>

          <div className="fines-with-actions__action">
            <div
              onClick={() => dispatch(setActiveModal('add-fines'))}
              className="fines-with-actions__action-item"
            >
              <Plus />
            </div>

            {data.length > 0 && (
              <div
                onClick={toggleEditable}
                className="fines-with-actions__action-item fines-with-actions__action-item--edit"
              >
                <NotePencil />
              </div>
            )}
          </div>
        </div>

        {data.length > 0 ? (
          <div className="row g-2">
            {data.map((item) => (
              <div key={item.id} className="col-lg-12">
                <div className="fines-with-actions__item">
                  <div className="d-flex justify-content-between align-items-center w-100">
                    <span className="fines-with-actions__text">{item.name}</span>

                    {isEditable && (
                      <div
                        onClick={() => handleRemove(item.id)}
                        className="fines-with-actions__delete"
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
          <span className="section-text">Fines is not found.</span>
        )}
      </div>
    </>
  );
};

export default FinesWithActions;
