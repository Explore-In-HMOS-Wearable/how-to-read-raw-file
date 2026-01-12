import { Users } from '../models/User';
import { util } from '@kit.ArkTS';
import { Product, ProductsData } from '../models/Product';
import { BusinessError } from '@kit.BasicServicesKit';
import { Post, PostsData } from '../models/Post';

export class RawFileManager {
  private static instance: RawFileManager;
  private static TAG: string = 'RawfileManager'
  private context?: Context;

  private constructor(context?: Context) {
    this.context = context;
  }

  public static getInstance(context?: Context): RawFileManager {
    if (!RawFileManager.instance) {
      RawFileManager.instance = new RawFileManager(context);
    }
    return RawFileManager.instance;
  }

  async readRawFileDeprecated(fileName: string): Promise<Users | undefined> {
    console.info(`${RawFileManager.TAG} readRawFfileDepracted called`)
    const rawFileContent = await this.getRawfileContent(fileName)
    if (rawFileContent) {
      const rawfileString = RawFileManager.uint8ArrayToString(rawFileContent)
      const json = RawFileManager.parseJson1(rawfileString)
      return json;
    }
    return undefined;
  }

  private async getRawfileContent(fileName: string): Promise<Uint8Array | undefined> {
    console.info(`${RawFileManager.TAG} getRawfileContent called`)
    const rawFileContent = await this.context?.resourceManager.getRawFileContent(fileName);
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
    const textDecoderOptions: util.TextDecoderOptions = {
      fatal: false,
      ignoreBOM: true
    }
    const decodeToStringOptions: util.DecodeToStringOptions = { stream: false }
    const textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);
    const retStr = textDecoder.decodeToString(array, decodeToStringOptions);
    return retStr;
  }

  //For json2.json
  async readRawFile2(filename: string): Promise<Array<Product>> {
    console.info(`${RawFileManager.TAG} readRawFile2 called`)
    let listArray: Array<Product> = []
    try {
      const rawFileContent = await this.getRawfileContent(filename)
      if (rawFileContent) {
        const fileData: string = RawFileManager.uint8ArrayToString2(rawFileContent)
        const obj = JSON.parse(fileData) as ProductsData;
        listArray = obj.products;
      }
    } catch (e) {
      console.error(`error is ${(e as BusinessError).message}`);
    }

    return listArray;
  }

  async readRawFile3(filename: string, context: Context | undefined): Promise<Array<Post>> {
    console.info(`${RawFileManager.TAG} readRawFile3 called`)
    context?.resourceManager.getRawFileContent(filename)
    let listArray: Array<Post> = []
    try {
      const rawFileContent = await this.getRawfileContent(filename)
      if (rawFileContent) {
        const fileData: string = RawFileManager.uint8ArrayToString2(rawFileContent)
        const obj = JSON.parse(fileData) as PostsData;
        listArray = obj.posts;
      }
    } catch (e) {
      console.error(`error is ${(e as BusinessError).message}`);
    }

    return listArray;
  }

  async readRawFile4(filename: string, context: Context | undefined) {
    console.info(`${RawFileManager.TAG} readRawFile4 called`)
    const fileDescriptor = await context?.resourceManager.getRawFd(filename);
    return fileDescriptor;
  }
}