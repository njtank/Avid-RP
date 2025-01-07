import React, { useState } from 'react';
import { useAutoAnimate } from '@formkit/auto-animate/react';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { deleteBanList } from '@/slices/departmentSlice';
import { setActiveModal } from '@/slices/globalSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import AddBanListModal from '@/modals/AddBanListModal';
import UserCard from '@/components/UserCard';
import SearchInput from '@/components/SearchInput';
import Button from '@/components/Button';

import './DepartmentBanList.scss';

const columns = {
  oneColumnTitle: 'Rank',
  twoColumnTitle: 'Date',
  threeColumnTitle: 'Banned by',
};

const DepartmentBanList = () => {
  const banList = useSelector((state: RootState) => state.departmentSlice.banList);
  const [searchValue, setSearchValue] = useState<string>('');
  const [animationParent] = useAutoAnimate();
  const dispatch = useDispatch();

  const filteredBanList = banList.filter((item) => {
    return item.name.toLowerCase().includes(searchValue.toLowerCase());
  });

  const handleDelete = (id: number) => {
    fetchNui('deleteBanList', {
      id,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteBanList(id));
          successNotify('Banned user is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteBanList(id));
          successNotify('Banned user is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted banned user.');
        }
      });
  };

  return (
    <>
      <AddBanListModal />

      <section className="department-ban-list">
        <div className="department-ban-list__header">
          <div className="section-line section-line--blue"></div>

          <h3 className="section-title">
            <span className="text-extrabold">Department</span> Ban List
          </h3>
        </div>

        <div className="department-ban-list__main">
          <div className="d-flex align-items-center mb-3">
            <SearchInput
              value={searchValue}
              setValue={setSearchValue}
              placeholder="Search Users in Department"
            />
            <Button
              onClick={() => dispatch(setActiveModal('add-ban-list'))}
              theme="purple"
              className="ms-3"
            >
              Add Banned User
            </Button>
          </div>

          <div ref={animationParent} className="department-ban-list__content">
            {banList.length > 0 ? (
              <>
                {filteredBanList.map((item) => (
                  <UserCard
                    key={item.id}
                    data={item}
                    columns={columns}
                    deleteOnClick={() => handleDelete(item.id)}
                  />
                ))}
              </>
            ) : (
              <span className="section-text">Banned users is not found.</span>
            )}
            {banList.length > 0 && filteredBanList.length === 0 && (
              <span className="section-text">Searching user is not found.</span>
            )}
          </div>
        </div>
      </section>
    </>
  );
};

export default DepartmentBanList;
