import { Text, Button, Radio, Spacer } from "@nextui-org/react"
import { setHours, setMinutes } from "date-fns";
import { Form, Formik, FormikHelpers, useField } from "formik";
import DatePickerField from "../FormFields/DatePickerField";
import InputField from "../FormFields/InputField";
import { at } from 'lodash';
import * as Yup from 'yup'
import { useCreateAppointmentToTaxIncomeMutation } from "../../storage/api";
import toast from "react-hot-toast";
import { Appointment } from "../../storage/types";

interface Values {
    day: string,
    hour: string,
    method: "office" | "phone"
    phone: string
}

const AppointmentTypeSelector = (props: { contactMethodFieldName: string, phone_field: string }) => {
    const [methodField, methodMeta, methodHelpers] = useField(props.contactMethodFieldName);

    function _renderHelperText() {
        const [touched, error] = at(methodMeta, 'touched', 'error');
        if (touched && error) {
            return error;
        }
    }

    return (
        <Radio.Group name={props.contactMethodFieldName} label="¿Como quedamos?" onChange={(v) => {methodHelpers.setValue(v)}}>
            <Radio name={props.contactMethodFieldName} value="phone" description="Tu asesor te llamará.">
                Cita telefónica
            </Radio>
            {methodField.value === 'phone' && <InputField name={props.phone_field} bordered label="Número de teléfono"/>}
            <Radio name={props.contactMethodFieldName} value="office" description="Tendrás que venir a nuestra oficina.">
                Cita presencial
            </Radio>
            <Text color="error">{_renderHelperText()}</Text>
        </Radio.Group>
    );
}

const AppointmentForm = (props: {appointment?: Appointment, edit?: boolean, onSubmit: (values: Values,
    formikHelpers: FormikHelpers<any>) => void }) => {
    
    const date = new Date(props.appointment?.time ?? '')

    return (
        <Formik initialValues={{ day: props.appointment?.time ?? '', hour: '12:30', method: props.appointment?.method ?? "office" as const, phone: ''}} validationSchema={Yup.object({
            day: Yup.date().required(),
            hour: Yup.string().min(4, "Hora inválida").required(),
            method: Yup.string(),
            phone: Yup.number().when('method', {is: "phone", then: Yup.number().min(9).required()})
          })
        } onSubmit={props.onSubmit}>
            <Form>
                <div className="flex flex-wrap place-content-center gap-4">
                    <DatePickerField name="day" />
                    <div>
                        <InputField name="hour" type="time" label="¿Sobre que hora?" rounded bordered fullWidth></InputField>
                        <Spacer />
                        <AppointmentTypeSelector contactMethodFieldName="method" phone_field="phone"/>
                    </div>
                </div>
                <Button
                    rounded
                    size="lg"
                    className="px-6 py-4 mt-8"
                    color="primary"
                    type="submit"
                >
                    Concertar cita
                </Button>
            </Form>
        </Formik>
    )
}


export default AppointmentForm;

