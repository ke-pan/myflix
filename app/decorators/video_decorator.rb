class VideoDecorator < Draper::Decorator
  delegate_all

  def rate
    return 0.0 if reviews_count == 0
    sum_rate = reviews.reduce(0.0) { |sum, review| sum + review.rate }
    "%.1f" % (sum_rate / reviews_count)
  end

end
