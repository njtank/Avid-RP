import React, { useState, useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import { setLocales, setIsFetchedLocales } from '@/slices/globalSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import Badge from '@/components/Badge';
import Messages from '@/components/Messages';
import Notifications from '@/components/Notifications';

import './Header.scss';

const Header = () => {
  const [pageTitle, setPageTitle] = useState<string>('Homepage');
  const [pageDescription, setPageDescription] = useState<string>(
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
  );
  const location = useLocation();
  const { info, locales, isFetchedLocales } = useSelector((state: RootState) => state.globalSlice);
  const { onlinePolice } = info;
  const dispatch = useDispatch();

  useEffect(() => {
    if (isFetchedLocales === 0) {
      fetchNui('getLocales', '')
        .then((res) => {
          if (res.success) {
            dispatch(setLocales(res.data));
            dispatch(setIsFetchedLocales(1));
          } else if (res.error) {
            errorNotify(res.message);
          }
        })
        .catch(() => {
          // for only development environment.
          // don't touch these.
          if (environmentCheck(true)) {
            dispatch(
              setLocales({
                pageDescription: {
                  none: 'Page description none.',
                  homepage: 'Homepage Description',
                  records: 'Records Description',
                  recordsDetail: 'Records Detail Description',
                  offenderDetail: 'Offender Detail Description',
                  policeDetail: 'Police Detail Description',
                  wanteds: 'Wanteds Description',
                  fines: 'Fines Description',
                  department: 'Department Description',
                  cameras: 'Cameras Description',
                  liveMap: 'Live Map Description',
                },
              }),
            );
            dispatch(setIsFetchedLocales(1));
          } else {
            errorNotify('Error ocurred while fetched data.');
          }
        });
    }
  }, []);

  useEffect(() => {
    const pathName = location.pathname;

    if (pathName === '/') {
      setPageTitle('Homepage');
      setPageDescription(locales.pageDescription.homepage);
    } else if (pathName === '/records') {
      setPageTitle('Records');
      setPageDescription(locales.pageDescription.records);
    } else if (pathName.includes('/records/')) {
      setPageTitle('Records Detail');
      setPageDescription(locales.pageDescription.recordsDetail);
    } else if (pathName.includes('/offenders/')) {
      setPageTitle('Offender Detail');
      setPageDescription(locales.pageDescription.offenderDetail);
    } else if (pathName.includes('/polices/')) {
      setPageTitle('Police Detail');
      setPageDescription(locales.pageDescription.policeDetail);
    } else if (pathName === '/wanteds') {
      setPageTitle('Wanteds');
      setPageDescription(locales.pageDescription.wanteds);
    } else if (pathName === '/fines') {
      setPageTitle('Fines');
      setPageDescription(locales.pageDescription.fines);
    } else if (pathName === '/department') {
      setPageTitle('Department');
      setPageDescription(locales.pageDescription.department);
    } else if (pathName === '/live-map') {
      setPageTitle('Live Map');
      setPageDescription(locales.pageDescription.liveMap);
    } else if (pathName === '/cameras') {
      setPageTitle('Cameras');
      setPageDescription(locales.pageDescription.cameras);
    } else {
      setPageTitle('');
      setPageDescription(locales.pageDescription.none);
    }
  }, [locales, location]);

  return (
    <header className="header">
      <div className="header__left-side">
        <h3 className="header__title">
          <span className="text-regular">GFX MDT</span> {pageTitle || pageTitle}
        </h3>
        <p className="header__text header__text--left-side">{pageDescription}</p>
      </div>

      <div className="header__right-side">
        <Messages className="ms-2" />
        <Notifications className="ms-2" />

        <div className="header__line"></div>

        <div className="d-flex align-items-center me-4">
          <span className="header__text text-nowrap">Online Police</span>
          <Badge theme="light-green" size="long" className="ms-2">
            {onlinePolice}
          </Badge>
        </div>

        <div className="d-flex align-items-center">
          <span className="header__text text-nowrap">Status</span>
          <Badge theme="light-green" size="long" className="ms-2">
            <div className="badge__circle badge__circle--red"></div>
          </Badge>
        </div>
      </div>
    </header>
  );
};

export default Header;
