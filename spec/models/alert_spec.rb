require 'spec_helper'

describe Alert do

  before(:each)do
		@attr = {:bus_route => "Dublin", :stop => "Bray", :first_alert => "20", :second_alert => 									"10", :third_alert => "5", :days_of_notification => "weekdays"}
	end

	it 'should accept the new alert' do
		Alert.create!(@attr)
	end

	describe "failure" do

		it "should not create an alert" do
			no_bus_route = Alert.new(@attr.merge(:bus_route => ""))
			no_bus_route.should_not be_valid
		end
	end

end
