# frozen_string_literal: true

require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @document = documents(:one)
  end

  test 'should get index' do
    get documents_url
    assert_response :success
  end

  test 'should get new' do
    get new_document_url
    assert_response :success
  end

  test 'should create document' do
    assert_difference('Document.count') do
      post documents_url,
           params: { document: { description: @document.description, name: @document.name, status: @document.status,
                                 tax_income_id: @document.tax_income_id } }
    end

    assert_redirected_to document_url(Document.last)
  end

  test 'should show document' do
    get document_url(@document)
    assert_response :success
  end

  test 'should get edit' do
    get edit_document_url(@document)
    assert_response :success
  end

  test 'should update document' do
    patch document_url(@document),
          params: { document: { description: @document.description, name: @document.name, status: @document.status,
                                tax_income_id: @document.tax_income_id } }
    assert_redirected_to document_url(@document)
  end

  test 'should destroy document' do
    assert_difference('Document.count', -1) do
      delete document_url(@document)
    end

    assert_redirected_to documents_url
  end
end