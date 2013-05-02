require 'spec_helper.rb'

describe Vagrant::ProvideOMatic::Config do
  subject { described_class.new }

  it "has the option to set provide-o-matic.yml path" do
    subject.should respond_to(:provide_o_matic_config_file)
  end

  it "sets provide-o-matic.yml default path" do
    subject.finalize!.should eql(File.expand_path("#{ENV['HOME']}/.provide-o-matic/provide-o-matic.yml"))
  end

  describe "#validate" do
    let(:env)     { double('env') }
    let(:config)  { double('config', provide_o_matic: subject) }
    let(:machine) { double('machine', config: config, env: env) }
    let(:result)  { subject.validate(machine) }

    context "when validations pass" do
      before(:each) do
        File.should_receive(:exists?).with(subject.provide_o_matic_config_file).and_return(true)
      end

      it "contains an empty Array for the 'provide-o-matic configuration' key" do
        result["provide-o-matic configuration"].should be_a(Array)
        result["provide-o-matic configuration"].should be_empty
      end
    end

    context "when validations fail" do
      before(:each) do
        File.should_receive(:exists?).with(subject.provide_o_matic_config_file).and_return(false)
      end

      it "contains an empty Array for the 'provide-o-matic configuration' key" do
        result["provide-o-matic configuration"].should be_a(Array)
        result["provide-o-matic configuration"].should_not be_empty
      end
    end
  end
end