import { Users } from "../models/User";
import { util } from "@kit.ArkTS";
import { Product, ProductsData } from "../models/Product";
import { BusinessError } from "@kit.BasicServicesKit";
import { Post, PostsData } from "../models/Post";

export class RawFileManager {
  private static instance: RawFileManager;
  private static TAG: string = "RawfileManager"

  private constructor() {
  }

  public static getInstance(): RawFileManager {
    if (!RawFileManager.instance) {
      RawFileManager.instance = new RawFileManager();
    }
    return RawFileManager.instance;
  }

  async readRawFileDeprecated(fileName: string) {
    console.info(`${RawFileManager.TAG} readRawFfileDepracted called`)
    const rawFileContent = await RawFileManager.getRawfileContent(fileName)
    const rawfileString = RawFileManager.uint8ArrayToString(rawFileContent)
    const json = RawFileManager.parseJson1(rawfileString)
    return json
  }

  private static async getRawfileContent(fileName: string) {
    console.info(`${RawFileManager.TAG} getRawfileContent called`)

    const rawFileContent = await getContext().resourceManager.getRawFileContent(fileName);

    return rawFileContent
  }

  private static uint8ArrayToString(array: Uint8Array): string {
    console.info(`${RawFileManager.TAG} uint8ArrayToString called`)

    return Array.from(array)
      .map(byte => String.fromCharCode(byte))
      .join('');
  }

  //For json1.json
  private static parseJson1(array: string): Users {
    console.info(`${RawFileManager.TAG} parseJson1 called`)

    const jsonData = JSON.parse(array) as Users
    return jsonData
  }

  //For json2.json
  private static uint8ArrayToString2(array: Uint8Array) {
    let textDecoderOptions: util.TextDecoderOptions = {
      fatal: false,
      ignoreBOM: true
    }
    let decodeToStringOptions: util.DecodeToStringOptions = {
      stream: false
    }
    let textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);
    let retStr = textDecoder.decodeToString(array, decodeToStringOptions);
    return retStr;
  }

  //For json2.json
  async readRawFile2(filename: string): Promise<Array<Product>> {
    console.info(`${RawFileManager.TAG} readRawFile2 called`)
    let listArray: Array<Product> = []
    try {
      const rawFileContent = await RawFileManager.getRawfileContent(filename)
      let file_data: string = RawFileManager.uint8ArrayToString2(rawFileContent)
      let obj = JSON.parse(file_data) as ProductsData;

      listArray = (obj as object)?.["products"];

    } catch (e) {
      console.error("error is " + (e as BusinessError).message);
    }

    return listArray;
  }

  async readRawFile3(filename: string, context: Context | undefined): Promise<Array<Post>> {
    console.info(`${RawFileManager.TAG} readRawFile3 called`)

    context?.resourceManager.getRawFileContent(filename)
    let listArray: Array<Post> = []
    try {
      const rawFileContent = await RawFileManager.getRawfileContent(filename)
      let file_data: string = RawFileManager.uint8ArrayToString2(rawFileContent)
      let obj = JSON.parse(file_data) as PostsData;

      listArray = (obj as object)?.["posts"];

    } catch (e) {
      console.error("error is " + (e as BusinessError).message);
    }

    return listArray;
  }

  async readRawFile4(filename: string, context: Context | undefined) {
    console.info(`${RawFileManager.TAG} readRawFile4 called`)

    let fileDescriptor = await context?.resourceManager.getRawFd(filename);


    return fileDescriptor;
  }
}