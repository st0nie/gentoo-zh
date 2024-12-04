# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="Kyocera printer driver for linux"
HOMEPAGE="https://www.kyoceradocumentsolutions.com.cn/support/mfp/download/"

SRC_URI="
	amd64?	( https://www.kyoceraconnect.com/servlet/kyocera.admin.DownloadServlet?actionType=download&id=1301
				-> kyodialog_${PV}-0_amd64.deb )
"

S="${WORKDIR}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="strip mirror bindist" # mirror as explained at bug #547372

RDEPEND="
	net-print/cups
	dev-qt/qtwidgets:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
"

pkg_nofetch() {
	einfo "Please download Kyodialog version ${PV} from"
	einfo "    ${HOMEPAGE}"
	einfo "Unpack it.Then you will get the file:"
	einfo "Debian/Global/kyodialog_amd64/kyodialog_9.4-0_amd64.deb"
	einfo "The archive should then be placed into your distfiles directory."
}

src_install() {
	exeinto /usr/bin
	exeopts -m0755
	doexe "${S}"/usr/bin/*

	exeinto /usr/lib
	exeopts -m0755
	doexe "${S}"/usr/lib/*

	# fix the icon patch
	sed -i "s/kyocera/kyocera9.4/g" "${$}"/usr/share/applications/kyodialog9.4.desktop
	insinto /usr/share
	doins -r "${S}"/usr/share/{applications,kyocera9.4}

	insinto /etc
	doins -r "${S}"/etc/{dbus-1,xdg}
}