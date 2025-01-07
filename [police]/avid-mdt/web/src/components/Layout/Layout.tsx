import React, { FC, useState } from 'react';
import { ToastContainer } from 'react-toastify';

import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import SearchModal from '@/components/SearchModal';
import './Layout.scss';

interface ILayoutProps {
  children: React.ReactNode;
}

const Layout: FC<ILayoutProps> = ({ children }) => {
  const [showSearchModal, setShowSearchModal] = useState<boolean>(false);

  return (
    <div className="layout">
      <ToastContainer />
      <SearchModal show={showSearchModal} setShow={setShowSearchModal} />

      <div className="layout__sidebar">
        <Sidebar setShowSearchModal={setShowSearchModal} />
      </div>

      <div className="layout__main">
        <div className="layout__header">
          <Header />
        </div>

        <div className="layout__content">{children}</div>
      </div>
    </div>
  );
};

export default Layout;
