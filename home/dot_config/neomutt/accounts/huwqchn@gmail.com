# vim: filetype=neomuttrc
# muttrc file for account huwqchn@gmail.com
set realname = "huwqchn"
set from = "huwqchn@gmail.com"
set sendmail = "msmtp -a huwqchn@gmail.com"
alias me huwqchn <huwqchn@gmail.com>
set folder = "/home/johnson/.local/share/mail/huwqchn@gmail.com"
set header_cache = /home/johnson/.cache/mutt-wizard/huwqchn@gmail.com/headers
set message_cachedir = /home/johnson/.cache/mutt-wizard/huwqchn@gmail.com/bodies
set mbox_type = Maildir
set hostname = "gmail.com"
source /usr/local/share/mutt-wizard/switch.muttrc
set spoolfile = +INBOX
set postponed = +Drafts
set trash = +Trash
set record = +Sent
