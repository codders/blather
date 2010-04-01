module Blather
class Stanza
module MUC
  
#  <x xmlns='http://jabber.org/protocol/muc#user'>
#    <invite to='jid'>
#      <reason>comment</reason>
#    </invite>
#  </x>
class Invite < Stanza
  register :x, :invite, "http://jabber.org/protocol/muc#user"
  
  def self.new(jid = nil, reason = nil, password = nil)
    invite = super :x
    invite.to       = jid
    invite.reason   = reason
    invite.password = password
    invite
  end
  
  def to=(jid)
    create_invite[:to] = JID.new(jid)
  end
  
  def to
    JID.new(create_invite[:to])
  end
  
  def reason=(reason)
    return if reason.blank?
    create_reason.content = reason
  end
  
  def reason
    create_reason.content
  end
  
  def password=(password)
    return if password.blank?
    create_password.content = password
  end
  
  def password
    create_password.content
  end
  
  protected
    def create_password
     unless create_password = find_first('ns:password', :ns => self.class.registered_ns)
        self << (create_password = XMPPNode.new('password', self.document))
      end
      create_password
    end
  
    def create_invite
      unless create_invite = find_first('ns:invite', :ns => self.class.registered_ns)
        self << (create_invite = XMPPNode.new('invite', self.document))
      end
      create_invite
    end

    def create_reason
      unless create_reason = create_invite.find_first('ns:reason', :ns => self.class.registered_ns)
        self.create_invite << (create_reason = XMPPNode.new('reason', self.document))
      end
      create_reason
    end
    
    def create_password
     unless create_password = find_first('ns:password', :ns => self.class.registered_ns)
        self << (create_password = XMPPNode.new('password', self.document))
      end
      create_password
    end
end

end
end
end