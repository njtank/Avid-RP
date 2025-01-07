import React, { useState, useEffect } from 'react';
import { useAutoAnimate } from '@formkit/auto-animate/react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setEditedWantedId, setActiveModal } from '@/slices/globalSlice';
import { deleteWanteds, setIsActiveEditingDeleted } from '@/slices/wantedsSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import AddWantedsModal from '@/modals/AddWantedsModal';
import UserCard from '@/components/UserCard';
import Button from '@/components/Button';
import Loader from '@/components/Loader';

import './WantedList.scss';

const columns = {
  oneColumnTitle: 'Rank',
  twoColumnTitle: 'Date',
  threeColumnTitle: 'Added by',
};

const WantedList = () => {
  const { editedWantedId } = useSelector((state: RootState) => state.globalSlice);
  const { wanteds, isFetched } = useSelector((state: RootState) => state.wantedsSlice);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [animationParent] = useAutoAnimate();
  const dispatch = useDispatch();

  const handleDelete = (id: number) => {
    if (editedWantedId === id) {
      dispatch(setIsActiveEditingDeleted(true));
    }

    fetchNui('deleteWanted', {
      id,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteWanteds(id));
          successNotify('Wanted is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for developement enivorment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteWanteds(id));
          successNotify('Wanted is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted wanted.');
        }
      });
  };

  useEffect(() => {
    setIsLoading(false);
  }, [wanteds]);

  return (
    <>
      <AddWantedsModal />

      <section className="wanted-list">
        <div className="wanted-list__header">
          <div className="d-flex align-items-center">
            <div className="section-line section-line--blue"></div>

            <h3 className="section-title">
              <span className="text-extrabold">Wanted</span> List
            </h3>
          </div>

          <Button
            onClick={() => dispatch(setActiveModal('add-wanteds'))}
            theme="purple"
            size="medium"
          >
            Add Wanted
          </Button>
        </div>

        <div ref={animationParent} className="wanted-list__main">
          {isLoading && isFetched === 0 ? (
            <Loader />
          ) : (
            <>
              {wanteds.length > 0 ? (
                <>
                  {wanteds
                    .slice()
                    .reverse()
                    .map((wanted) => (
                      <UserCard
                        key={wanted.id}
                        data={wanted}
                        columns={columns}
                        deleteOnClick={() => handleDelete(wanted.id)}
                        editOnClick={() => dispatch(setEditedWantedId(wanted.id))}
                        className={editedWantedId === wanted.id ? 'is-editing' : ''}
                      />
                    ))}
                </>
              ) : (
                <span className="section-text">Wanteds is not found.</span>
              )}
            </>
          )}
        </div>
      </section>
    </>
  );
};

export default WantedList;
