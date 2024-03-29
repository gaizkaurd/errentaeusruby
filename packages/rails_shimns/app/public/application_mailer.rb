# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  append_view_path(Rails.root.glob('packages/*/*/app/views'))
  default from: 'ERRENTA.EUS <gestion@elizaasesores.com>', reply_to: 'ERRENTA.EUS <contacto@elizaasesores.com>'
  layout 'mailer'
end
