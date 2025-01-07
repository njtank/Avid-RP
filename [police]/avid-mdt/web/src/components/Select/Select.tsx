import React, { FC } from 'react';
import cx from 'classnames';

import './Select.scss';

type optionsType = {
  id: string;
  value: string;
  name: string;
};

interface ISelectProps extends React.SelectHTMLAttributes<HTMLSelectElement> {
  options: optionsType[];
  defaultValue?: any;
  styleType?: 'one' | 'two';
  className?: string;
}

const Select: FC<ISelectProps> = ({ options, defaultValue, styleType, className, ...res }) => {
  return (
    <div className="select-container">
      <select
        className={cx(
          'select',
          {
            [`select--style-${styleType}`]: styleType,
          },
          className,
        )}
        defaultValue={defaultValue}
        {...res}
      >
        {options.map((option) => (
          <option key={option.id} id={option.id} value={option.value} className="select__option">
            {option.name}
          </option>
        ))}
      </select>
    </div>
  );
};

export default Select;
