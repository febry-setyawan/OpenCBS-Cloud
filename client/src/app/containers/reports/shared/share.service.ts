import { Injectable } from "@angular/core";
@Injectable()
export class ShareService {
  private data: any;

  public setData(data) {
    this.data = data;
  }

  public getData() {
    let temp = this.data;
    this.clearData();
    return temp;
  }

  private clearData() {
    this.data = undefined;
  }
}
