class TestChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'test'
  end
end
