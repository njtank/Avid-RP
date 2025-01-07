import React, { FC, useEffect, useRef } from 'react';
import { X } from '@phosphor-icons/react';
import { useOnClickOutside } from 'usehooks-ts';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setActiveModal } from '@/slices/globalSlice';

import './Modal.scss';

interface IModalProps {
  title: string;
  submitButton: string;
  type?: string;
  onSubmit: any;
  children: React.ReactNode;
}

const Modal: FC<IModalProps> = ({
  title = 'Modal Title',
  submitButton = 'Submit',
  type,
  onSubmit,
  children,
}) => {
  const ref = useRef<HTMLDivElement>(null);
  const refInner = useRef(null);
  const activeModal = useSelector((state: RootState) => state.globalSlice.activeModal);
  const dispatch = useDispatch();

  const handleClose = () => {
    ref.current?.classList.remove('is-active');

    setTimeout(() => {
      dispatch(setActiveModal(''));
    }, 350);
  };

  useEffect(() => {
    if (type === activeModal) {
      setTimeout(() => {
        ref.current?.classList.add('is-active');
      }, 1);
    }
  }, [activeModal]);

  useOnClickOutside(refInner, handleClose);

  return (
    <>
      {type === activeModal && (
        <div ref={ref} className="modal">
          <div ref={refInner} className="modal__inner">
            <div className="modal__header">
              <h3 className="modal__title">{title}</h3>

              <div onClick={handleClose} className="modal__close">
                <X />
              </div>
            </div>

            <div className="modal__main">{children}</div>

            <div className="modal__footer">
              <button onClick={handleClose} className="modal__button me-2">
                Cancel
              </button>
              <button onClick={onSubmit} className="modal__button modal__button--blue">
                {submitButton}
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
};

export default Modal;
