# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 3) do

  create_table "cells", :force => true do |t|
    t.column "lat",        :float,    :default => 0.0
    t.column "lon",        :float,    :default => 0.0
    t.column "mcc",        :integer
    t.column "mnc",        :integer
    t.column "range",      :integer,  :default => 0
    t.column "nbSamples",  :integer,  :default => 0
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "mesures", :force => true do |t|
    t.column "lat",        :float,    :default => 0.0
    t.column "lon",        :float,    :default => 0.0
    t.column "cell_id",    :integer
    t.column "created_at", :datetime
  end

  create_table "open_id_associations", :force => true do |t|
    t.column "server_url", :binary
    t.column "handle",     :string
    t.column "secret",     :binary
    t.column "issued",     :integer
    t.column "lifetime",   :integer
    t.column "assoc_type", :string
  end

  create_table "open_id_nonces", :force => true do |t|
    t.column "nonce",   :string
    t.column "created", :integer
  end

  create_table "open_id_settings", :force => true do |t|
    t.column "setting", :string
    t.column "value",   :binary
  end

  create_table "users", :force => true do |t|
    t.column "login",                     :string
    t.column "email",                     :string
    t.column "crypted_password",          :string,   :limit => 40
    t.column "salt",                      :string,   :limit => 40
    t.column "created_at",                :datetime
    t.column "updated_at",                :datetime
    t.column "remember_token",            :string
    t.column "remember_token_expires_at", :datetime
    t.column "open_id_url",               :string
  end

end
