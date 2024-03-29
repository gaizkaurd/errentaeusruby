# config/initializers/stripe.rb
Stripe.api_key             = ENV.fetch('STRIPE_SECRET_KEY', nil)
StripeEvent.signing_secret = ENV.fetch('STRIPE_SIGNING_SECRET', nil)

billing_mode = ENV.fetch('BILLING_MODE', 'test')

Stripe.api_key =
  if billing_mode == 'live'
    ENV.fetch('STRIPE_SECRET_LIVE_KEY', nil)
  else
    ENV.fetch('STRIPE_SECRET_TEST_KEY', nil)
  end

StripeEvent.signing_secrets = [
  ENV.fetch('STRIPE_SIGNING_TEST_SECRET', nil),
  ENV.fetch('STRIPE_SIGNING_LIVE_SECRET', nil)
].compact

class EventFilter
  def call(event)
    event.api_key =
      if event.livemode
        ENV.fetch('STRIPE_SECRET_LIVE_KEY', nil)
      else
        ENV.fetch('STRIPE_SECRET_TEST_KEY', nil)
      end
    event
  end
end

StripeEvent.event_filter = EventFilter.new

Rails.application.reloader.to_prepare do
  StripeEvent.configure do |events|
    # events.subscribe 'checkout.session.completed', StripeWebhooks::CheckoutSessionCompleted.new
    # events.subscribe 'customer.subscription.created', StripeWebhooks::SubscriptionUpdated.new
    # events.subscribe "customer.subscription.updated", StripeWebhooks::SubscriptionUpdated.new
    # events.subscribe "customer.subscription.deleted", StripeWebhooks::SubscriptionDeleted.new
    # events.subscribe 'invoice.created', StripeWebhooks::InvoiceCreated.new
    # events.subscribe 'invoice.payment_succeeded', StripeWebhooks::InvoicePaymentSucceeded.new
    events.subscribe 'payment_intent.succeeded', PaymentSucceededPubSub
    events.subscribe 'payment_intent.amount_capturable_updated', PaymentIntentAmountCapturableUpdatedPubSub
    events.subscribe 'customer.subscription.updated', CustomerSubscriptionUpdatedPubSub
    events.subscribe 'customer.subscription.deleted', CustomerSubscriptionDeletedPubSub
  end
end
