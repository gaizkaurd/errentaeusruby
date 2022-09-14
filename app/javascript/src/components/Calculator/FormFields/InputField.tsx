import React from 'react';
import { at } from 'lodash';
import { useField } from 'formik';
import { Input } from '@nextui-org/react'

export default function InputField({...props}) {
  const { errorText, ...rest } = props;
  const [field, meta] = useField(props.name);

  function _renderHelperText() {
    const [touched, error] = at(meta, 'touched', 'error');
    if (touched && error) {
      return error;
    }
  }

  function _renderColor() {
    if (meta.touched) {
      if (meta.error) {
        return "error"
      }
      return "success"
    } 
    return "default"
  }

  return (
    <Input
      type="text"
      color={_renderColor()}
      helperText={_renderHelperText()}
      size="xl"
      {...field}
      {...rest}
    />
  );
}