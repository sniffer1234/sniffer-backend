class Admin::DashboardController < Admin::BaseController

  # GET /admin/dashboard
  def index
    @new_users = User.newest
    @most_active_users = User.activers

    @pending_establishments = Establishment.pending
    @pending_events = Event.pending

    @count = {
      users: User.all.size,
      establishments: Establishment.all.size,
      sniffs: Sniff.all.size,
      events: Event.all.size
    }
  end

end
