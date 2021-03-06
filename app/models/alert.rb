class Alert < ActiveRecord::Base

	belongs_to :user

	# queries for the alerts that are due to be sent
	def self.alerter(b, s, d, t)
		# It would have been nice to do this query all in rails
	#	where(:bus_route => b, :stop => s, :third_alert => t)

#"The 06:30 To Wexford"
#"Camolin"
		# this is more a raw sql query				AND active = 'true'
		Alert.where("bus_route = '#{b}' AND stop = '#{s}' AND active = ? AND (days_of_notification = '#{d}' OR days_of_notification = 'Everyday') AND (first_alert = '#{t}' OR second_alert = '#{t}' OR third_alert = '#{t}')", true)
    #find_users_to_alert(t)
  end
	
	# accesible attributes of the model		
	attr_accessible :bus_route, :stop, :first_alert, :second_alert, :third_alert, :active, 
								:days_of_notification, :user_id
	
	# checking fields are present
	validates :bus_route, :presence => true
	validates :stop, :presence => true
	validates :days_of_notification, :presence => true
	#	validates :active, :presence => true

	# check form fields are present and integers
	validates :first_alert, :presence => true, :numericality => {:only_integer => true}
	validates :second_alert, :presence => true, :numericality => {:only_integer => true}
	validates :third_alert, :presence => true, :numericality => {:only_integer => true}

	validates :user_id, :presence => true

	DAYS = ["Everyday", "Weekdays", "Weekends"]

	# hash to map the stop id to stop stored in the db
	STOPS = {1 => 'Dublin Airport (Coach Park)', 2 => 'Arklow - Old Dublin Rd', 3 => 'Gorey', 4 => 'Camolin', 5 => 'Ferns', 6 => 'Enniscorthy', 7 => 'Oylgate', 8 => 'Wexford', 9 => 'Dublin Airport (Coach Park)', 10 => 'Arklow - Old Dublin Rd', 11 => 'Gorey', 12 => 'Camolin', 13 => 'Ferns', 14 => 'Enniscorthy', 15 => 'Oylgate', 16 => 'Wexford', 17 => 'Dublin Airport (Coach Park)', 18 => 'Northwall / O2 Arena', 19 => 'Georges Quay', 20 => 'Lr Merrion St (Irish American College)', 21 => 'Montrose Hotel (UCD)', 22 => 'Arklow - Old Dublin Rd', 23 => 'Gorey', 24 => 'Camolin', 25 => 'Ferns', 26 => 'Enniscorthy', 27 => 'Oylgate', 28 => 'Wexford', 29 => 'Dublin Airport (Coach Park)', 30 => 'Northwall / O2 Arena', 31 => 'Georges Quay', 32 => 'Lr Merrion St (Irish American College)', 33 => 'Montrose Hotel (UCD)', 34 => 'Arklow - Old Dublin Rd', 35 => 'Gorey', 36 => 'Camolin', 37 => 'Ferns', 38 => 'Enniscorthy', 39 => 'Oylgate', 40 => 'Wexford', 41 => 'Dublin Airport (Coach Park)', 42 => 'Northwall / O2 Arena', 43 => 'Georges Quay', 44 => 'Lr Merrion St (Irish American College)', 45 => 'Montrose Hotel (UCD)', 46 => 'Arklow - Old Dublin Rd', 47 => 'Gorey', 48 => 'Camolin', 49 => 'Ferns', 50 => 'Enniscorthy', 51 => 'Oylgate', 52 => 'Wexford', 53 => 'Dublin Airport (Coach Park)', 54 => 'Northwall / O2 Arena', 55 => 'Georges Quay', 56 => 'Lr Merrion St (Irish American College)', 57 => 'Montrose Hotel (UCD)', 58 => 'Arklow - Old Dublin Rd', 59 => 'Gorey', 60 => 'Camolin', 61 => 'Ferns', 62 => 'Enniscorthy', 63 => 'Oylgate', 64 => 'Wexford', 65 => 'Dublin Airport (Coach Park)', 66 => 'Northwall / O2 Arena', 67 => 'Georges Quay', 68 => 'Lr Merrion St (Irish American College)', 69 => 'Montrose Hotel (UCD)', 70 => 'Arklow - Old Dublin Rd', 71 => 'Gorey', 72 => 'Camolin', 73 => 'Ferns', 74 => 'Enniscorthy', 75 => 'Oylgate', 76 => 'Wexford', 77 => 'Dublin Airport (Coach Park)', 78 => 'Northwall / O2 Arena', 79 => 'Georges Quay', 80 => 'Lr Merrion St (Irish American College)', 81 => 'Montrose Hotel (UCD)', 82 => 'Arklow - Old Dublin Rd', 83 => 'Gorey', 84 => 'Camolin', 85 => 'Ferns', 86 => 'Enniscorthy', 87 => 'Oylgate', 88 => 'Wexford', 89 => 'Dublin Airport (Coach Park)', 90 => 'Northwall / O2 Arena', 91 => 'Georges Quay', 92 => 'Lr Merrion St (Irish American College)', 93 => 'Montrose Hotel (UCD)', 94 => 'Arklow - Old Dublin Rd', 95 => 'Gorey', 96 => 'Camolin', 97 => 'Ferns', 98 => 'Enniscorthy', 99 => 'Oylgate', 100 => 'Wexford', 101 => 'Dublin Airport (Coach Park)', 102 => 'Northwall / O2 Arena', 103 => 'Georges Quay', 104 => 'Lr Merrion St (Irish American College)', 105 => 'Montrose Hotel (UCD)', 106 => 'Arklow - Old Dublin Rd', 107 => 'Gorey', 108 => 'Camolin', 109 => 'Ferns', 110 => 'Enniscorthy', 111 => 'Oylgate', 112 => 'Wexford', 113 => 'Wexford', 114 => 'Oylgate', 115 => 'Enniscorthy', 116 => 'Ferns', 117 => 'Camolin', 118 => 'Gorey', 119 => 'Arklow - Old Dublin Rd', 120 => 'Dublin Airport (Coach Park)', 121 => 'Wexford', 122 => 'Oylgate', 123 => 'Enniscorthy', 124 => 'Ferns', 125 => 'Camolin', 126 => 'Gorey', 127 => 'Arklow - Old Dublin Rd', 128 => 'UCD', 129 => 'Clare St (National Gallery)', 130 => 'Custom House Quay', 131 => 'Northwall / O2 Arena', 132 => 'Dublin Airport (Coach Park)', 133 => 'Wexford', 134 => 'Oylgate', 135 => 'Enniscorthy', 136 => 'Ferns', 137 => 'Camolin', 138 => 'Gorey', 139 => 'Arklow - Old Dublin Rd', 140 => 'UCD', 141 => 'Clare St (National Gallery)', 142 => 'Custom House Quay', 143 => 'Northwall / O2 Arena', 144 => 'Dublin Airport (Coach Park)', 145 => 'Wexford', 146 => 'Oylgate', 147 => 'Enniscorthy', 148 => 'Ferns', 149 => 'Camolin', 150 => 'Gorey', 151 => 'Arklow - Old Dublin Rd', 152 => 'UCD', 153 => 'Clare St (National Gallery)', 154 => 'Custom House Quay', 155 => 'Northwall / O2 Arena', 156 => 'Dublin Airport (Coach Park)', 157 => 'Wexford', 158 => 'Oylgate', 159 => 'Enniscorthy', 160 => 'Ferns', 161 => 'Camolin', 162 => 'Gorey', 163 => 'Arklow - Old Dublin Rd', 164 => 'UCD', 165 => 'Clare St (National Gallery)', 166 => 'Custom House Quay', 167 => 'Northwall / O2 Arena', 168 => 'Dublin Airport (Coach Park)', 169 => 'Wexford', 170 => 'Oylgate', 171 => 'Enniscorthy', 172 => 'Ferns', 173 => 'Camolin', 174 => 'Gorey', 175 => 'Arklow - Old Dublin Rd', 176 => 'UCD', 177 => 'Clare St (National Gallery)', 178 => 'Custom House Quay', 179 => 'Northwall / O2 Arena', 180 => 'Dublin Airport (Coach Park)', 181 => 'Wexford', 182 => 'Oylgate', 183 => 'Enniscorthy', 184 => 'Ferns', 185 => 'Camolin', 186 => 'Gorey', 187 => 'Arklow - Old Dublin Rd', 188 => 'UCD', 189 => 'Clare St (National Gallery)', 190 => 'Custom House Quay', 191 => 'Northwall / O2 Arena', 192 => 'Dublin Airport (Coach Park)', 193 => 'Wexford', 194 => 'Oylgate', 195 => 'Enniscorthy', 196 => 'Ferns', 197 => 'Camolin', 198 => 'Gorey', 199 => 'Arklow - Old Dublin Rd', 200 => 'UCD', 201 => 'Clare St (National Gallery)', 202 => 'Custom House Quay', 203 => 'Northwall / O2 Arena', 204 => 'Dublin Airport (Coach Park)', 205 => 'Wexford', 206 => 'Oylgate', 207 => 'Enniscorthy', 208 => 'Ferns', 209 => 'Camolin', 210 => 'Gorey', 211 => 'Arklow - Old Dublin Rd', 212 => 'UCD', 213 => 'Clare St (National Gallery)', 214 => 'Custom House Quay', 215 => 'Northwall / O2 Arena', 216 => 'Dublin Airport (Coach Park)', 217 => 'Wexford', 218 => 'Oylgate', 219 => 'Enniscorthy', 220 => 'Ferns', 221 => 'Camolin', 222 => 'Gorey', 223 => 'Arklow - Old Dublin Rd', 224 => 'UCD', 225 => 'Clare St (National Gallery)', 226 => 'Custom House Quay', 227 => 'Northwall / O2 Arena', 228 => 'Dublin Airport (Coach Park)'}

	ROUTES = {1 => 'The 00:30 To Wexford', 2 => 'The 06:30 To Wexford', 3 => 'The 08:30 To Wexford', 4 => 'The 10:30 To Wexford', 5 => 'The 12:30 To Wexford', 6 => 'The 14:30 To Wexford', 7 => 'The 16:30 To Wexford', 8 => 'The 17:15 To Wexford', 9 => 'The 19:30 To Wexford', 10 => 'The 22:30 To Wexford', 11 => 'The 01:30 To Dublin', 12 => 'The 05:00 To Dublin', 13 => 'The 06:15 To Dublin', 14 => 'The 07:30 To Dublin', 15 => 'The 09:30 To Dublin', 16 => 'The 11:30 To Dublin', 17 => 'The 13:30 To Dublin', 18 => 'The 15:30 To Dublin', 19 => 'The 17:30 To Dublin', 20 => 'The 19:30 To Dublin'}

end
