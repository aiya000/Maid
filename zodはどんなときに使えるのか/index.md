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
    <a href="https://aiya000.booth.pm/items/1298622"><img src="./setulab-cover.png" class="book" /></a>
    <a href="https://aiya000.booth.pm/items/1298622"><img src="./setulab-backcover.png" class="book" /></a>
</div>

- - - - -

## 僕

こういう数学の本を書いてます。

[![](./nico-cover.png)](https://aiya000.booth.pm/items/1040121)

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
// fooがFoo型でなければ例外を送出し、
// そうでなければfoo: Foo | SomeをFoo型にして返す。
const foo_: Foo = fooSchema.parse(foo)
```

- - - - -

#### TypeScriptを書くとき ぜんぶ

Type Guardも自分で書かなくてよくなる！

```typescript
const isFoo = (x: unknown): x is Foo =>
  // xがFoo型であればtrueを、そうでなければfalseを返す
  fooSchema.safeParse(x).success
```

- - - - -

#### Type Guardも自分で書かなくてよくなる！

# なにがいい？

- - - - -

#### Type Guardも自分で書かなくてよくなる！

実はTypeScriptって、型を守ったプログラムを書くのがむずかしいです。

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
  x.bar === 'number' &&  // 故にtypeofし忘れしたり、などなどをする
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
// unknownで、型を守った受け取りをする
const isFoo = (x: unknown): x is Foo =>
  // Type Guardのロジックを自前で書かないので、書き間違えをすることもない
  fooSchema.safeParse(x).success
```

- - - - -

#### Type Guardも自分で書かなくてよくなる！

ちなみに弊社では

```typescript
// いちいちType Guardを書かなくていいやつ
const isValueOf = <T>(
  x: ZodType<T, ZodTypeDef>, // T型のzodスキーマの型
  y: unknown
): y is T => x.safeParse(y).success

if (isValueOf(fooSchema, foo)) {
  const foo_: Foo = foo
}
```

- - - - -

→ **型を書くとき**『**ぜんぶ**』zodは使える

→ TypeScriptで型を書かないときなんて、ないよね

- - - - -

# → 『ぜんぶ』

- - - - -

### 応用例

- [tRPC](https://github.com/trpc/trpc)
    - バックエンドとフロントエンドの両方でzodスキーマを共有するやつ
    - **API呼び出しに型を付ける**ことができる
- [zod-prisma](https://github.com/CarterGrimmeisen/zod-prisma)
    - **Prismaモデル**からzodスキーマを出力するやつ

- - - - -

### 応用例

- [vee-validate/zod](https://vee-validate.logaretm.com/v4/integrations/zod-schema-validation/)
    - zodの**強力なバリデーション機構**を使って、Webフォームのバリデーションをするやつ
    - zodは型の検証だけでなく、**バリデーションを実行することができる**
        - 例: メールアドレスを表すスキーマ: `z.string().email()`

- - - - -

### 応用例
# [vee-validate/zod](https://vee-validate.logaretm.com/v4/integrations/zod-schema-validation/)

- - - - -

### 応用例 > vee-validate/zod

InputText.vue

```html
<template>
  <input
    v-model="text"
    type="text"
    :placeholder="placeholder"
  />
  <span v-if="validatorRules && errorMessage">{{ errorMessage }}</span>
</template>
```

- - - - -

InputText.vue（続き）  
（`<script setup lang="ts">`）

```typescript
import { ZodType, ZodEffects, ZodTypeDef } from 'zod'

type FieldInput = string | number | null
const props = withDefaults(
  defineProps<{
    modelValue: FieldInput,
    placeholder?: string
    validatorName?: string
    validatorRules?: ZodType<string, ZodTypeDef, FieldInput>
  }>(),
  // ...
```

- - - - -

InputText.vue（続き）  
（`<script setup lang="ts">`）

```typescript
import { useField } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'

// emit('update:modelValue', x)時にバリデーションされる
const { value, errorMessage } = useField<FieldInput>(
  toRef(props, 'validatorName'),
  props.validatorRules
    ? toTypedSchema(props.validatorRules)
    : toTypedSchema(z.unknown()),
  { initialValue: props.modelValue }
)
```

- - - - -

### 応用例 > vee-validate/zod

/pages/foo.vue

```html
<template>
  <div>
    <InputText
      v-model="text"
      validator-name="text"
      :validator-rules="url"
    />
  </div>
</template>
```

- - - - -

/pages/foo.vue（続き）  
（`<script setup lang="ts">`）

```typescript
import { z } from 'zod'

const url = z.string().url({
  message: 'URLを入力してください'
})
```

- - - - -

/pages/foo.vue

![](1.png)

- - - - -

/pages/foo.vue

![](2.png)

- - - - -

ご清聴ありがとうございました
