class Bindfs < Formula
  desc "FUSE file system for mounting to another location"
  homepage "https://bindfs.org/"
  url "https://bindfs.org/downloads/bindfs-1.17.3.tar.gz"
  sha256 "c16876091572c23242c16e87c5be7e3512f443aae637328d8c011c071e9302eb"
  license "GPL-2.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "10a28033bad3c35be2156fac80b911e209fdb98009aba5f454d285e84343a885"
  end

  head do
    url "https://github.com/mpartel/bindfs.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libfuse"
  depends_on :linux # on macOS, requires closed-source macFUSE

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    if build.head?
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end

    system "make", "install"
  end

  test do
    system "#{bin}/bindfs", "-V"
  end
end
