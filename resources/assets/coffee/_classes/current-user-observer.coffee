###
#    Copyright 2015-2017 ppy Pty. Ltd.
#
#    This file is part of osu!web. osu!web is distributed with the hope of
#    attracting more community contributions to the core ecosystem of osu!.
#
#    osu!web is free software: you can redistribute it and/or modify
#    it under the terms of the Affero GNU General Public License version 3
#    as published by the Free Software Foundation.
#
#    osu!web is distributed WITHOUT ANY WARRANTY; without even the implied
#    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with osu!web.  If not, see <http://www.gnu.org/licenses/>.
###

class @CurrentUserObserver
  constructor: ->
    @covers = document.getElementsByClassName('js-current-user-cover')
    @avatars = document.getElementsByClassName('js-current-user-avatar')

    $.subscribe 'user:update', @setData
    $(document).on 'turbolinks:load', @reinit
    $.subscribe 'osu:page:change', @reinit


  reinit: =>
    @setAvatars()
    @setCovers()


  setAvatars: (elements) =>
    elements ?= @avatars

    bgImage = if currentUser.id? then "url('#{currentUser.avatar_url}')" else ''
    for el in elements
      el.style.backgroundImage = bgImage


  setCovers: (elements) =>
    elements ?= @covers

    bgImage = if currentUser.id? then "url('#{currentUser.cover_url}')" else ''
    for el in elements
      el.style.backgroundImage = bgImage


  setData: (_e, data) =>
    window.currentUser = data

    @reinit()
