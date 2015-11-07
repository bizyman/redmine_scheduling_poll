class SchedulingPollItem < ActiveRecord::Base
  unloadable

  belongs_to :scheduling_poll
  has_many :scheduling_vote, :dependent => :destroy

  validates :scheduling_poll, :presence => true
  validates :text, :presence => true, :allow_blank => false

  def vote_by_user(user)
    self.scheduling_vote.where(:user => user).first
  end
  def users
    self.scheduling_vote.map {|v| v.user }
  end

  def vote(user, value=0)
    value = value.to_i
    v = self.vote_by_user(user)
    unless value == 0
      if v.nil?
        v = self.scheduling_vote.create(:user => user, :value => value, :create_at => Time.now)
      else
        v.update(:value => value, :modify_at => Time.now)
      end
    else # remove vote
      v.destroy unless v.nil?
    end
    v
  end
end
