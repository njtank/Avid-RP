import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import type { RootState } from '@/store';
import { useSelector, useDispatch } from 'react-redux';
import {
  setPoliceDetail,
  deleteRankFromPoliceDetail,
  deleteEvidenceFromPoliceDetail,
} from '@/slices/policesSlice';
import { fetchNui } from '@/utils/fetchNui';
import { errorNotify, successNotify } from '@/utils/notification';
import environmentCheck from '@/utils/environmentCheck';

import FoundEvidences from '@/components/FoundEvidences';
import Ranks from '@/components/Ranks';
import Textarea from '@/components/Textarea';
import Loader from '@/components/Loader';
import HelpMessage from '@/components/HelpMessage';

import profileImage from '@/assets/images/recording-details-profile-image.png';
import evidenceExampleImage from '@/assets/images/evidence-example-image.webp';
import './PoliceDetail.scss';

const PoliceDetail = () => {
  const { policeDetail } = useSelector((state: RootState) => state.policesSlice);
  const [formReportText, setFormReportText] = useState<string>('');
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [isDuplicate, setIsDuplicate] = useState<number>(0);
  const { id, avatar, name, madeBy, ranks, reportText, evidences } = policeDetail;
  const dispatch = useDispatch();
  const { id: policeId } = useParams();

  const handleDeleteRank = (id: number) => {
    fetchNui('deleteRankFromPolice', {
      id,
      policeId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteRankFromPoliceDetail(id));
          successNotify('Rank is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteRankFromPoliceDetail(id));
          successNotify('Rank is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted rank.');
        }
      });
  };

  const handleDeleteEvidence = (id: number) => {
    fetchNui('deleteEvidenceFromPolice', {
      id,
      policeId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(deleteEvidenceFromPoliceDetail(id));
          successNotify('Rank is successfully deleted.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(deleteEvidenceFromPoliceDetail(id));
          successNotify('Evidence is successfully deleted.');
        } else {
          errorNotify('Error occurred while deleted evidence.');
        }
      });
  };

  const handleSubmitReportText = () => {
    setIsDuplicate((current: any) => (current += 1));

    if (isDuplicate > 1) return;

    fetchNui('editReportTextFromPolice', {
      id,
      reportText: formReportText,
    })
      .then((res) => {
        if (res.success) {
          successNotify('Report text is succesfully updated.');
        } else if (res.error) {
          errorNotify(res.message);
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          successNotify('Report text is succesfully updated.');
        } else {
          errorNotify('Error occurred while updated report text.');
        }
      });
  };

  useEffect(() => {
    setIsLoading(true);

    fetchNui('getPoliceDetail', {
      id: policeId,
    })
      .then((res) => {
        if (res.success) {
          dispatch(setPoliceDetail(res.data));
        }
      })
      .catch(() => {
        // for only development environment.
        // don't touch these.
        if (environmentCheck(true)) {
          dispatch(
            setPoliceDetail({
              id: 0,
              avatar: profileImage,
              name: 'Yordi',
              madeBy: 'Yordi',
              ranks: [
                {
                  id: 1,
                  name: 'Suspect',
                },
                {
                  id: 2,
                  name: 'Murderer',
                },
              ],
              reportText: 'test',
              evidences: [
                {
                  id: 1,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
                {
                  id: 2,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
                {
                  id: 3,
                  image: evidenceExampleImage,
                  name: 'Bloody Knife',
                },
              ],
            }),
          );
        } else {
          errorNotify('Error occurred while fetched data.');
        }
      });
  }, []);

  useEffect(() => {
    setTimeout(() => {
      setIsLoading(false);
      setFormReportText(reportText);
    }, 300);
  }, [policeDetail]);

  return (
    <section className="police-detail">
      <div className="police-detail__header">
        <div className="section-line section-line--blue"></div>

        <h3 className="section-title">
          <span className="text-extrabold">Police</span> Detail
        </h3>
      </div>

      <div className="police-detail__main">
        {isLoading ? (
          <Loader />
        ) : (
          <>
            <div className="d-flex">
              <div className="police-detail__avatar mr-15">
                <img src={avatar} alt="" className="police-detail__avatar-img" />
              </div>

              <div className="d-flex flex-column">
                <span className="police-detail__title">{name}</span>
                <p className="police-detail__text">#{id}</p>

                <Ranks
                  data={ranks}
                  handleRemove={handleDeleteRank}
                  addWhere="police-detail"
                  hideAddRank={true}
                  hideEditRank={true}
                  className="mt-1"
                />

                <span className="police-detail__by-made mt-2">
                  This process made by <span className="text-extrabold">{madeBy}</span>.
                </span>
              </div>
            </div>

            <div className="police-detail__hr"></div>

            <div className="d-flex flex-column mb-4">
              <div className="d-flex align-items-center mb-15">
                <div className="section-square section-square--blue"></div>
                <span className="section-title section-title--medium text-bold">
                  Minutes Reports
                </span>
              </div>

              <Textarea
                value={formReportText}
                setValue={setFormReportText}
                onSubmit={handleSubmitReportText}
              />
              {isDuplicate > 2 && (
                <HelpMessage status="error">
                  You{"'"}re updating so fast, please take a break.
                </HelpMessage>
              )}
            </div>

            <FoundEvidences
              data={evidences}
              handleRemove={handleDeleteEvidence}
              addWhere="police-detail"
            />
          </>
        )}
      </div>
    </section>
  );
};

export default PoliceDetail;
