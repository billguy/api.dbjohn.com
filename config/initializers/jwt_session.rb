JWTSessions.algorithm = 'HS256'
JWTSessions.encryption_key = ENV['JWT_ENCYPTION_KEY']
# Only disable this when testing
# JWTSessions.access_exp_time = 10