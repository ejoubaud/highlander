require 'spec_helper'

describe PayloadAdapters::TeamCityBuildComplete do

  subject { described_class.new(notification.with_indifferent_access) }

  let(:base_notification) do
    {
      "build"=> {
        "buildStatus"=>"Running",
        "buildResult"=>"success",
        "buildResultPrevious"=>"success",
        "buildResultDelta"=>"unchanged",
        "notifyType"=>"buildFinished",
        "buildFullName"=>"marketplace :: [0] Build number assignment",
        "buildName"=>"[0] Build number assignment",
        "buildId"=>"56697",
        "buildTypeId"=>"bt36",
        "buildInternalTypeId"=>"bt36",
        "buildExternalTypeId"=>"bt36",
        "buildStatusUrl"=>
         "http://ian.local:8111/viewLog.html?buildTypeId=bt36&buildId=56697",
        "buildStatusHtml"=>
         "<span class=\"tcWebHooksMessage\"><a href=\"http://ian.local:8111/project.html?projectId=Marketplace\">marketplace</a> :: <a href=\"http://ian.local:8111/viewType.html?buildTypeId=bt36\">[0] Build number assignment</a> # <a href=\"http://ian.local:8111/viewLog.html?buildTypeId=bt36&buildId=56697\"><strong>6927</strong></a> has <strong>finished</strong> with a status of <a href=\"http://ian.local:8111/viewLog.html?buildTypeId=bt36&buildId=56697\"> <strong>success</strong></a> and was triggered by <strong>Sean St. Quentin</strong></span>",
        "rootUrl"=>"http://ian.local:8111",
        "projectName"=>"marketplace",
        "projectId"=>"Marketplace",
        "projectInternalId"=>"project2",
        "projectExternalId"=>"Marketplace",
        "buildNumber"=>"6927",
        "agentName"=>"telly",
        "agentOs"=>"Mac OS X, version 10.7.4",
        "agentHostname"=>"192.168.1.57",
        "triggeredBy"=>"Anonymous Coward",
        "message"=>
         "Build marketplace :: [0] Build number assignment has finished. This is build number 6927, has a status of \"success\" and was triggered by Sean St. Quentin",
        "text"=>
         "marketplace :: [0] Build number assignment has finished. Status: success",
        "buildStateDescription"=>"finished",
        "buildRunners"=>nil,
        "extraParameters"=>nil
      }
    }      
  end

  describe "#triggered_by" do
    let(:notification) {
      base_notification.deep_merge("build" => { "triggeredBy" => "Gary Glitter" })
    }

    it "is the correct user" do
      subject.triggered_by.should == "Gary Glitter"
    end
  end

  describe "#user" do
    let(:notification) {
      base_notification.deep_merge("build" => { "triggeredBy" => "Gary Glitter" })
    }

    it "should return the user matched on their name" do
      user = mock("User")
      subject.stub(:triggered_by).and_return("Gary Glitter")
      User.should_receive(:find_by_name).with("Gary Glitter").and_return(user)

      subject.user.should == user
    end
  end

  describe "#green?" do

    context "when the build is a success" do
      let(:notification) {
        base_notification.deep_merge("build" => { "buildResult" => "success" })
      }

      it "should return true" do
        subject.should be_green
      end
    end

    context "when the build is a failure" do
      let(:notification) {
        base_notification.deep_merge("build" => { "buildResult" => "failure" })
      }

      it "should return false" do
        subject.should_not be_green
      end
    end
  end

end
