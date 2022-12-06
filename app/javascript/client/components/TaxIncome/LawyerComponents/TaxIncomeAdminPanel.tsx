import { Text } from "@nextui-org/react";
import { Field, Form, Formik } from "formik";
import { t } from "i18next";
import {
  useGetUserByIdQuery,
  useUpdateTaxIncomeMutation,
} from "../../../storage/api";
import {
  TaxIncome,
  TaxIncomeStatuses,
} from "../../../storage/models/TaxIncome";
export const TaxIncomeAdminPanel = (props: { taxIncome: TaxIncome }) => {
  const { data } = useGetUserByIdQuery(props.taxIncome.user);
  const [updateTaxIncome] = useUpdateTaxIncomeMutation();

  const onSubmit = (values: any) => {
    console.log(values);
    updateTaxIncome({
      id: props.taxIncome.id,
      ...values,
    });
  };

  return (
    <div>
      <Text h3>Usuario {data?.first_name}</Text>
      <Formik
        initialValues={{ state: props.taxIncome.state, price: 0 }}
        onSubmit={onSubmit}
      >
        <Form>
          <Field as="select" name="state">
            {TaxIncomeStatuses.map((val, id) => {
              return (
                <option key={id} value={val}>
                  {t(`taxincome.statuses.${val}`)}
                </option>
              );
            })}
          </Field>
          <Field name="price"></Field>
          <Field name="year"></Field>
          <button type="submit">guardar</button>
        </Form>
      </Formik>
    </div>
  );
};
