require 'spec_helper'

describe UserDecorator do

  let(:decorator) { described_class.new(user) }

  describe '#link' do
    subject { decorator.link }

    let(:user) { User.new(nickname: 'satyr') }

    before do
      allow(h).to receive(:profile_path).with(user) { '/path' }
    end

    context "when user has id" do
      before do
        user.id = 1
      end

      it "is a nickname link to user's profile" do
        expect(subject).to eq('<a href="/path" title="satyr">satyr</a>')
      end
    end

    context "when user has no id" do
      before do
        user.id = nil
      end

      it "is user's nickname" do
        expect(subject).to eq('satyr')
      end
    end
  end

  describe '#img_link' do
    subject { decorator.img_link }

    let(:user) { User.new(nickname: 'satyr') }

    before do
      allow(h).to receive(:profile_path).with(user) { '/path' }
      allow(decorator).to receive(:avatar_image_tag) { '<img ...>'.html_safe }
    end

    context "when user has id" do
      before do
        user.id = 1
      end

      it "is an avatar link to user's profile" do
        expect(subject).to eq('<a href="/path" title="satyr"><img ...></a>')
      end
    end

    context "when user has no id" do
      before do
        user.id = nil
      end

      it "is user's avatar image" do
        expect(subject).to eq('<img ...>')
      end
    end
  end

  describe '#fullname_and_nickname' do
    subject { decorator.fullname_and_nickname }

    let(:user) { double('user', nickname: 'sickill', name: name) }

    context "when full name is present" do
      let(:name) { 'Marcin Kulik' }

      it { should eq('Marcin Kulik (sickill)') }
    end

    context "when fill name is missing" do
      let(:name) { nil }

      it { should eq('sickill') }
    end
  end

end
