# zodはどんなときに使えるのか

- 2023-06-13
- [aiya000](https://twitter.com/public_ai000ya)

- - - - -

## zodはどんなときに使えるのか

- - - - -

## TypeScriptを書くとき
## ぜんぶ

- - - - -

# ＿人人人人人＿
# ＞　ぜんぶ　＜
# ￣Y^Y^Y^Y^Y^￣

- - - - -

## 僕

<img src="./profile.png" class="profile" />
- 名前
    - aiya000
- Twitter
    - pubilc\_ai000ya

- - - - -

## 僕

こういう数学の本を書いてます。

<div>
    <img src="./setulab-cover.png" class="book" />
    <img src="./setulab-backcover.png" class="book" />
</div>

- - - - -

## 僕

こういう数学の本を書いてます。

![](./nico-cover.png)

- - - - -

## TypeScriptを書くとき ぜんぶ

- - - - -

#### TypeScriptをinterfaceで書くとき

```typescript
interface Foo {
  bar: number
  baz?: number
}

const foo: Foo | Some = {
  bar: 42,
}

// interfaceに対するinstanceofはできない
if (foo instanceof Foo) {
  const foo_: Foo = foo
}
```

- - - - -

できない？

```typescript
// interfaceに対するinstanceofはできない
if (foo instanceof Foo) {
  const foo_: Foo = foo
}
```

- - - - -

#### TypeScriptを書くとき ぜんぶ

zodで型を定義すればできる！！

```typescript
import { z } from 'zod'

const fooSchema = z.object({
  bar: z.number(),
  baz: z.number().optional(),
})
type Foo = z.infer<typeof fooSchema>
// = { bar: number baz?: number }

const foo: Foo | Some = {
  bar: 42,
}

const foo_: Foo = fooSchema.parse(foo)
```

- - - - -

#### TypeScriptを書くとき ぜんぶ

```typescript
// ↓ fooSchema.parse(foo)
// fooがFoo型でなければ例外を送出し、
// そうでなければfoo: Foo | SomeをFoo型にして返す。
const foo_: Foo = fooSchema.parse(foo)
```

- - - - -

#### TypeScriptを書くとき ぜんぶ

Type Guardも自分で書かなくてよくなる！

```typescript
const isFoo = (x: unknown): x is Foo =>
  fooSchema.safeParse(x).success

// ↓fooSchema.safeParse(x).success
// xがFoo型であればtrueを、そうでなければfalseを返す
```

- - - - -

#### Type Guardも自分で書かなくてよくなる！

# なにがいい？

- - - - -

#### Type Guardも自分で書かなくてよくなる！

実はTypeScriptって、型健全なプログラムを書くのがむずかしいです。

```typescript
// 利便性のため、Type Guardの定義には、しばしばanyを使う
const isFoo = (x: any): x is Foo =>
  typeof x.bar === 'number' &&
  (typeof x.baz === 'number' || x.baz === undefined)
```

- - - - -

#### Type Guardも自分で書かなくてよくなる！

```typescript
// ↓anyを使うと、静的型付けを無効にする = 型不健全な処理が書ける
const isFoo = (x: any): x is Foo =>
```

- - - - -

#### Type Guardも自分で書かなくてよくなる！

```typescript
// ↓anyを使うと、静的型付けを無効にする = 型不健全な処理が書ける
const isFoo = (x: any): x is Foo => true
  x.bar === 'number' &&  // 故にtypeofし忘れしたりする
  (typeof x.baz === 'number' || x.baz === undefined)
```

- - - - -

#### Type Guardも自分で書かなくてよくなる！

Type Guardはバグの温床だけど、でもType Guardは使いたいよね……？

- - - - -

👉 そこでzod

- - - - -

#### Type Guardも自分で書かなくてよくなる！

```typescript
// unknownで型健全な受け取りをする
const isFoo = (x: unknown): x is Foo =>
  // Type Guardのロジックを自前で書かないので、書き間違えをすることもない
  fooSchema.safeParse(x).success
```

- - - - -

→ 型を書くとき『ぜんぶ』zodは使える

→ TypeScriptで型を書かないときなんて、ないよね

- - - - -

# → 『ぜんぶ』

- - - - -

### 応用例

- [tRPC](https://github.com/trpc/trpc)
    - バックエンドとフロントエンドの両方でzodスキーマを共有するやつ
    - API呼び出しに型を付けることができる

TODO

- - - - -

## TypeScriptを書くとき
## ぜんぶ

- - - - -

## ~~TypeScript~~JavaScriptを書くとき
## ぜんぶ

- - - - -

zodを使うことにより、データ構造が定義できる。
データの処理がわかりやすくなる。

TODO
