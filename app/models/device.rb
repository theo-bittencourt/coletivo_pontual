class Device < ActiveRecord::Base
  def on_receive_position
    connection.execute "LISTEN tracker"
    connection.raw_connection.wait_for_notify do |event, pid, position|
      yield position
    end
  ensure
    connection.execute "UNLISTEN tracker"
  end
end
