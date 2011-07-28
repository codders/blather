require 'spec_helper'

def muc_user_xml
  <<-XML
    <presence from="aaaa@conference.localhost/system" to="system@localhost/18429142301311847368905620" lang="en">
      <x xmlns="http://jabber.org/protocol/muc#user">
        <item jid="system@localhost/18429142301311847368905620" affiliation="owner" role="moderator"/>
      </x>
    </presence>
  XML
end

describe Blather::Stanza::Presence::MUCUser do
  it 'registers itself' do
    Blather::XMPPNode.class_from_registration(:muc_user, nil).must_equal Blather::Stanza::Presence::MUCUser
  end

  it 'must be importable' do
    Blather::XMPPNode.import(parse_stanza(muc_user_xml).root).must_be_instance_of Blather::Stanza::Presence::MUCUser
  end
end
