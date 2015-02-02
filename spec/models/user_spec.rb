require 'spec_helper'

describe User do
  it { should have_many(:posts).dependent(:destroy) }
end
