@Component
export struct AppIcon {
  @Prop source: Resource = $r('app.media.ic_play')
  @Prop iconSize: number = 22
  @Prop color: string = '#FFFFFF'
  build() {
    Image(this.source).width(this.iconSize).height(this.iconSize)
      .objectFit(ImageFit.Contain).fillColor(this.color)
  }
}


