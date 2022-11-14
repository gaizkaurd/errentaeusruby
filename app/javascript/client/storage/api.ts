import { BaseQueryFn, createApi } from "@reduxjs/toolkit/query/react";
import axios, { AxiosError, AxiosRequestConfig } from "axios";
import {
  TaxIncomesResponse,
  Appointment,
  TaxIncome,
  TaxIncomeData,
  Estimation,
  IUser,
  PaymentDetails,
  Document,
  DocumentHistory,
} from "./types";

const axiosBaseQuery =
  (
    { baseUrl }: { baseUrl: string } = { baseUrl: "" }
  ): BaseQueryFn<
    {
      url: string;
      method: AxiosRequestConfig["method"];
      data?: AxiosRequestConfig["data"];
      params?: AxiosRequestConfig["params"];
    },
    unknown,
    unknown
  > =>
  async ({ url, method, data, params }) => {
    try {
      const result = await axios({ url: baseUrl + url, method, data, params });
      return { data: result.data };
    } catch (axiosError) {
      const err = axiosError as AxiosError;
      return {
        error: {
          status: err.response?.status,
          data: err.response?.data || err.message,
        },
      };
    }
  };

export const taxIncomeApi = createApi({
  reducerPath: "taxIncomeApi",
  baseQuery: axiosBaseQuery({ baseUrl: "/api/v1/" }),
  tagTypes: [
    "TaxIncome",
    "Appointment",
    "Estimation",
    "Lawyer",
    "Document",
    "DocumentHistory",
  ],
  endpoints: (build) => ({
    getTaxIncomes: build.query<TaxIncomesResponse, void>({
      query: () => ({ url: "tax_incomes", method: "get" }),
      providesTags: (result) =>
        result
          ? [
              ...result.map(({ id }) => ({ type: "TaxIncome" as const, id })),
              { type: "TaxIncome", id: "LIST" },
            ]
          : [{ type: "TaxIncome", id: "LIST" }],
    }),
    getTaxIncomeById: build.query<TaxIncome, string>({
      query: (id) => ({ url: `tax_incomes/${id}`, method: "get" }),
      providesTags: (_result, _error, id) => [{ type: "TaxIncome", id }],
    }),
    createTaxIncome: build.mutation<TaxIncome, TaxIncomeData>({
      query: (data) => ({ url: `tax_incomes`, method: "post", data: data }),
      invalidatesTags: [{ type: "TaxIncome", id: "LIST" }],
    }),
    getAppointments: build.query<Appointment[], void>({
      query: () => ({ url: "appointments", method: "get" }),
      providesTags: (result) =>
        result
          ? [
              ...result.map(({ id }) => ({ type: "Appointment" as const, id })),
              { type: "Appointment", id: "LIST" },
            ]
          : [{ type: "Appointment", id: "LIST" }],
    }),
    createAppointmentToTaxIncome: build.mutation<
      Appointment,
      Partial<Appointment>
    >({
      query: (data) => ({ url: "appointments", method: "post", data: data }),
      invalidatesTags: (result) => [
        { type: "TaxIncome", id: result?.tax_income_id },
        { type: "Appointment", id: "LIST" },
      ],
    }),
    getAppointmentById: build.query<Appointment, string>({
      query: (id) => ({ url: `appointments/${id}`, method: "get" }),
      providesTags: (_result, _error, id) => [{ type: "Appointment", id }],
    }),
    getEstimationById: build.query<Estimation, string>({
      query: (id) => ({ url: `estimations/${id}`, method: "get" }),
      providesTags: (_result, _error, id) => [{ type: "Estimation", id }],
    }),
    getLawyerById: build.query<IUser, string>({
      query: (id) => ({ url: `lawyers/${id}`, method: "get" }),
      providesTags: (_result, _error, id) => [{ type: "Lawyer", id }],
    }),
    updateAppointmentById: build.mutation<Appointment, Partial<Appointment>>({
      query: (data) => ({
        url: `appointments/${data.id}`,
        method: "put",
        params: data,
      }),
      invalidatesTags: (result, _error) => [
        { type: "Appointment", id: result?.id },
      ],
    }),
    getPaymentDataOfTaxIncome: build.query<PaymentDetails, string>({
      query: (id) => ({ url: `tax_incomes/${id}/payment_data`, method: "get" }),
    }),
    getDocumentsOfTaxIncome: build.query<Document[], string>({
      query: (id) => ({ url: `tax_incomes/${id}/documents`, method: "get" }),
      providesTags: (result, _error, _arg) =>
        result
          ? [
              ...result.map(({ id }) => ({ type: "Document" as const, id })),
              { type: "Document", id: "LIST" },
            ]
          : [{ type: "Document", id: "LIST" }],
    }),
    getDocumentById: build.query<Document, string>({
      query: (id) => ({ url: `documents/${id}`, method: "get" }),
      providesTags: (_result, _error, id) => [{ type: "Document", id }],
    }),
    deleteDocumentAttachmentById: build.mutation<
      Document,
      { document_id: string; attachment_id: string }
    >({
      query: (data) => ({
        url: `documents/${data.document_id}/delete_document_attachment/${data.attachment_id}`,
        method: "delete",
      }),
      invalidatesTags: (result, _error) => [
        { type: "Document", id: result?.id },
      ],
    }),
    addAttachmentToDocument: build.mutation<
      Document,
      { document_id: string; files: any }
    >({
      query: (data) => ({
        url: `documents/${data.document_id}/add_document_attachment/`,
        method: "post",
        data: data.files,
      }),
      invalidatesTags: (result, _error) => [
        { type: "Document", id: result?.id },
      ],
    }),
    createDocument: build.mutation<Document, { files: any }>({
      query: (data) => ({
        url: `documents`,
        method: "post",
        body: { files: data.files },
      }),
      invalidatesTags: (result, _error) => [
        { type: "Document", id: result?.id },
      ],
    }),
    exportDocumentById: build.mutation<Document, string>({
      query: (data) => ({
        url: `documents/${data}/export_document`,
        method: "post",
      }),
      invalidatesTags: (result, _error) => [
        { type: "Document", id: result?.id },
      ],
    }),
    getDocumentHistoryById: build.query<DocumentHistory[], string>({
      query: (id) => ({ url: `documents/${id}/history`, method: "get" }),
    }),
  }),
});

export const {
  useGetTaxIncomesQuery,
  useGetTaxIncomeByIdQuery,
  useCreateTaxIncomeMutation,
  useCreateAppointmentToTaxIncomeMutation,
  useGetAppointmentByIdQuery,
  useGetEstimationByIdQuery,
  useGetLawyerByIdQuery,
  useGetAppointmentsQuery,
  useUpdateAppointmentByIdMutation,
  useGetPaymentDataOfTaxIncomeQuery,
  useGetDocumentsOfTaxIncomeQuery,
  useDeleteDocumentAttachmentByIdMutation,
  useAddAttachmentToDocumentMutation,
  useCreateDocumentMutation,
  useGetDocumentByIdQuery,
  useExportDocumentByIdMutation,
  useGetDocumentHistoryByIdQuery,
} = taxIncomeApi;