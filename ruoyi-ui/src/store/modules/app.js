import Cookies from 'js-cookie'

const state = {
  sidebar: {
    opened: Cookies.get('sidebarStatus') ? !!+Cookies.get('sidebarStatus') : true,
    withoutAnimation: false,
    hide: false
  },
  courseDetailSideBar:{
    opened: Cookies.get('courseDetailSideBarStatus') ? !!+Cookies.get('courseDetailSideBarStatus') : true,
    withoutAnimation: false,
    hide: false

  },
  device: 'desktop',
  size: Cookies.get('size') || 'medium'
}

const mutations = {
  TOGGLE_SIDEBAR: state => {
    if (state.sidebar.hide) {
      return false;
    }
    state.sidebar.opened = !state.sidebar.opened
    state.sidebar.withoutAnimation = false
    if (state.sidebar.opened) {
      Cookies.set('sidebarStatus', 1)
    } else {
      Cookies.set('sidebarStatus', 0)
    }
  },
  CLOSE_SIDEBAR: (state, withoutAnimation) => {
    Cookies.set('sidebarStatus', 0)
    state.sidebar.opened = false
    state.sidebar.withoutAnimation = withoutAnimation
  },
  TOGGLE_DEVICE: (state, device) => {
    state.device = device
  },
  SET_SIZE: (state, size) => {
    state.size = size
    Cookies.set('size', size)
  },
  SET_SIDEBAR_HIDE: (state, status) => {
    state.sidebar.hide = status
  },
  TOGGLE_COURSE_SIDEBAR: state => {
    if (state.courseDetailSideBar.hide) {
      return false;
    }
    state.courseDetailSideBar.opened = !state.courseDetailSideBar.opened
    state.courseDetailSideBar.withoutAnimation = false
    if (state.courseDetailSideBar.opened) {
      Cookies.set('courseDetailSideBarStatus', 1)
    } else {
      Cookies.set('courseDetailSideBarStatus', 0)
    }
  },
  CLOSE_COURSE_SIDEBAR: (state, withoutAnimation) => {
    Cookies.set('courseDetailSideBarStatus', 0)
    state.courseDetailSideBar.opened = false
    state.courseDetailSideBar.withoutAnimation = withoutAnimation
  },
  SET_COURSE_SIDEBAR_HIDE: (state, status) => {
    state.courseDetailSideBar.hide = status
  }
}

const actions = {
  toggleSideBar({ commit }) {
    commit('TOGGLE_SIDEBAR')
  },
  closeSideBar({ commit }, { withoutAnimation }) {
    commit('CLOSE_SIDEBAR', withoutAnimation)
  },
  toggleDevice({ commit }, device) {
    commit('TOGGLE_DEVICE', device)
  },
  setSize({ commit }, size) {
    commit('SET_SIZE', size)
  },
  toggleSideBarHide({ commit }, status) {
    commit('SET_SIDEBAR_HIDE', status)
  },
  toggleCourseSideBar({ commit }) {
    commit('TOGGLE_COURSE_SIDEBAR')
  },
  closeCourseSideBar({ commit }, { withoutAnimation }) {
    commit('CLOSE_COURSE_SIDEBAR', withoutAnimation)
  },
  toggleCourseSideBarHide({ commit }, status) {
    commit('SET_COURSE_SIDEBAR_HIDE', status)
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
