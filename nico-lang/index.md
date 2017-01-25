# nico-langについて

- nico-lang is published in  
  [https://github.com/aiya000/nico-lang](https://github.com/aiya000/nico-lang)
- This slide is published in  
  [https://aiya000.github.io/Maid/nico-lang](https://aiya000.github.io/Maid/nico-lang)
- aiya000（あいや）

- - - - -

# nico-langとは
- 矢澤にこ言語
- Brainf*ck方言

- - - - -

# Hello, world

'HELLO' と出力するコード

```
笑顔届ける矢澤にこにこ！にっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにこにーはみんなのもの！だめだめだめっ！
にっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにー笑顔届ける矢澤にこにこ！にこにーって覚えてラブニコ！ｷﾓﾁﾜﾙｲだめだめだめっ！
ぴょんぴょんぴょんっ！笑顔届ける矢澤にこにこ！笑顔届ける矢澤にこにこ！にっこにっこにーにっこにっこにーにっこにっこにーにこにーはみんなのもの！だめだめだめっ！
にっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにー笑顔届ける矢澤にこにこ！にこにーって覚えてラブニコ！ｷﾓﾁﾜﾙｲだめだめだめっ！
ぴょんぴょんぴょんっ！笑顔届ける矢澤にこにこ！笑顔届ける矢澤にこにこ！にっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにこにーはみんなのもの！だめだめだめっ！
にっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにー笑顔届ける矢澤にこにこ！にこにーって覚えてラブニコ！ｷﾓﾁﾜﾙｲだめだめだめっ！
ぴょんぴょんぴょんっ！笑顔届ける矢澤にこにこ！笑顔届ける矢澤にこにこ！にっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにこにーはみんなのもの！だめだめだめっ！
にっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにー笑顔届ける矢澤にこにこ！にこにーって覚えてラブニコ！ｷﾓﾁﾜﾙｲだめだめだめっ！
ぴょんぴょんぴょんっ！笑顔届ける矢澤にこにこ！笑顔届ける矢澤にこにこ！にっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにこにーはみんなのもの！だめだめだめっ！
にっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにーにっこにっこにー笑顔届ける矢澤にこにこ！にこにーって覚えてラブニコ！ｷﾓﾁﾜﾙｲだめだめだめっ！
にっこにっこにーぴょんぴょんぴょんっ！笑顔届ける矢澤にこにこ！
```

- - - - -

# やったこと

- パーサー作り
- 評価器作り
- テスト作り

- - - - -

# パーサー作り

- - - - -

## パーサー

```haskell
-- Parse a code to [NicoOperation]
codeParser :: Parser (Maybe [NicoOperation])
codeParser = do
  tokens <- tokensParser
  let mayOperations = mapM (flip M.lookup operationMap) tokens
  return mayOperations

-- Parse a code to tokens
tokensParser :: Parser [Text]
tokensParser = do
  blocks <- P.many tokenBlockParser
  let tokens = concat blocks
  return tokens

-- Parse a block
tokenBlockParser :: Parser [Text]
tokenBlockParser = do
  skipNonToken
  P.many tokenParser

-- Match any token
tokenParser :: Parser Text
tokenParser = foldl1' (<|>) . map (P.try . P.string) $ tokenTexts

-- Skip other than the token
skipNonToken :: Parser ()
skipNonToken = do
  let heads = map T.head tokenTexts
  P.skipWhile (`notElem` heads)
  (void $ P.lookAhead tokenParser) <|> (P.anyChar >> skipNonToken)
```

- - - - -

Haskellなら簡単に出来るね！

- - - - -

Haskellなら簡単に出来るね！
- 所要時間 2日 + 3週間くらい
    - 2日: 某合宿
    - 3週間: やる日があったりなかったりなかったり
    - 実質 2 + 5日分（？？）くらい？

- - - - -

詳しい時系列はGitHub上もしくはローカルの`git log`で見れるよ！

- - - - -

# 評価器作り

- - - - -

## 評価器

（130行くらい）

```haskell
-- | Evaluate and execute NicoLangProgram with the virtual machine state
eval :: NicoLangProgram -> NicoState NicoMemory
eval operationList = do
  opP <- gets nicoProgramPointer
  if operationAreFinished operationList opP
    then gets nicoMemory
    else do
      let op = operationList !! opP
      executeOperation op
      eval operationList
  where
    operationAreFinished :: NicoLangProgram -> NicoProgramPointer -> Bool
    operationAreFinished xs ptr = length xs == ptr


-- Proceed the nicoProgramPointer to the next memory address
programGoesToNext :: NicoState ()
programGoesToNext = do
  machine@(NicoMachine _ _ opP _) <- get
  put machine { nicoProgramPointer = opP + 1 }

-- Get the nicoMemoryPointer pointed value in the nicoMemory
getCurrentCell :: NicoState Int
getCurrentCell = do
  (NicoMachine mem memP _ _) <- get
  case M.lookup memP mem of
    Nothing  -> return 0  -- 0 is the initial value of the cell
    Just val -> return val

-- Set the value to the nicoMemoryPointer pointed nicoMemory address
setCurrentCell :: Int -> NicoState ()
setCurrentCell val = do
  machine@(NicoMachine mem memP _ _) <- get
  put machine { nicoMemory = M.insert memP val mem }


-- Execute a specified operation
executeOperation :: NicoOperation -> NicoState ()
executeOperation NicoForward = do
  logging
  machine <- get
  memP    <- gets nicoMemoryPointer
  put machine { nicoMemoryPointer = memP + 1 }
  programGoesToNext
  where
    logging :: NicoState ()
    logging = do
      memP <- gets nicoMemoryPointer
      tell ["Forward the nicoMemoryPointer to " ++ show (memP + 1)]

executeOperation NicoBackword = do
  logging
  machine <- get
  memP    <- gets nicoMemoryPointer
  put machine { nicoMemoryPointer = memP - 1 }
  programGoesToNext
  where
    logging :: NicoState ()
    logging = do
      memP <- gets nicoMemoryPointer
      tell ["Backward the nicoMemoryPointer to " ++ show (memP - 1)]

executeOperation NicoIncr = do
  logging
  cell    <- getCurrentCell
  setCurrentCell $ cell + 1
  programGoesToNext
  where
    logging :: NicoState ()
    logging = do
      cell <- getCurrentCell
      memP <- gets nicoMemoryPointer
      tell ["Increment (nicoMemory !! " ++ show memP ++ ") to " ++ show (cell + 1)]

executeOperation NicoDecr = do
  logging
  cell    <- getCurrentCell
  setCurrentCell $ cell - 1
  programGoesToNext
  where
    logging :: NicoState ()
    logging = do
      cell <- getCurrentCell
      memP <- gets nicoMemoryPointer
      tell ["Decrement (nicoMemory !! " ++ show memP ++ ") to " ++ show (cell - 1)]

executeOperation NicoOutput = do
  cell <- getCurrentCell
  liftIO $ putChar $ chr cell
  programGoesToNext

executeOperation NicoInput = do
  val <- liftIO . fmap ord $ getChar
  logging val
  setCurrentCell val
  programGoesToNext
  where
    logging :: Int -> NicoState ()
    logging val = do
      memP <- gets nicoMemoryPointer
      tell ["Get " ++ show val ++ " from stdin, " ++ "and set it to (nicoMemory !! " ++ show memP ++ ")"]

executeOperation NicoLoopBegin = do
  logging
  machine@(NicoMachine _ _ opP lbPStack) <- get
  put machine { nicoLoopBeginPointerStack = opP:lbPStack }
  programGoesToNext
  where
    logging = do
      opP <- gets nicoProgramPointer
      tell ["Push " ++ show opP ++ " to the pointer stack"]

executeOperation NicoLoopEnd = do
  machine  <- get
  lbPStack <- gets nicoLoopBeginPointerStack
  case lbPStack of
    []              -> error "Cannot find the loop jump destination :("
    (lbP:lbPStack') -> do
      put machine { nicoLoopBeginPointerStack = lbPStack' }
      cell <- getCurrentCell
      if cell /= 0
        then do
          loggingForLoopJump lbP
          put machine { nicoProgramPointer = lbP }
        else do
          loggingForLoopFinish lbP
          programGoesToNext
  where
    loggingForLoopJump   :: Int -> NicoState ()
    loggingForLoopJump   lbP = tell ["Pop " ++ show lbP ++ " from the pointer stack, and set it as the next program pointer"]
    loggingForLoopFinish :: Int -> NicoState ()
    loggingForLoopFinish lbP = tell ["Pop " ++ show lbP ++ " from the pointer stack, and leave from the one of loop"]
```

- - - - -

Haskellなら簡単に…オッオッオッ（困惑）

- - - - -

Haskellなら簡単に…オッオッオッ（困惑）
- 所要時間 1週間くらい
    - やる日があったりなかったりなかったり
    - 実質4日くらい？

- - - - -

# テスト作り

- - - - -

## テスト

```haskell
main :: IO ()
main = do
  inOutTests <- getInOutTests
  Test.defaultMain $
    Test.testGroup "nico-lang test" $
      [ PT.test
      , inOutTests
      ]

getInOutTests :: IO TestTree
getInOutTests = do
  inOutPairs  <- map inOutFiles . testNames . filter (`notElem` [".", ".."]) <$> getDirectoryContents "test/in-out"
  inOutPairs' <- sequence . map (twiceMapM readFile) $ inOutPairs
  -- `init` removes the line break of the tail
  let inOutPairs'' = map (second init) inOutPairs'
  resultPairs <- forM inOutPairs'' $ firstMapM $ \source -> do
    case parse . T.pack $ source of
      Left  e -> return . Left $ "Parse error: " ++ show e
      Right a -> return . Right =<< (capture_ . flip runNicoState emptyMachine $ eval a)
  return $ Test.testGroup "in-out matching test" $
    flip map resultPairs $ \case
      (Left e, outData)       -> Test.testCase (show outData) $ Test.assertFailure e
      (Right inData, outData) -> Test.testCase (show outData) $ inData @?= outData
  where
    testNames :: [FilePath] -> [FilePath]
    testNames  = nub . map (takeWhile (/='.'))
    inOutFiles :: FilePath -> (FilePath, FilePath)
    inOutFiles = (printf "test/in-out/%s.nico") &&& (printf "test/in-out/%s.out")
```

- - - - -

Haskellなら格好良く書けるね！

- - - - -

Haskellなら格好良く書けるね！
- TDD + 型の変更などにより  
  作業が全体的に跨っていて、期間が算出不可
    - ベース作り: 1日
    - 追記・修正（NOT 変更）: 2日分
    - くらい？？

- - - - -

# はい
少し一息つこう

- - - - -

# 工夫したところ

- - - - -

## Brainf*ckコードとの相互変換可能にした
- niconvertで`brainf*ck -> nico`のコード変換
- `NicoLangProgram`型のshow（文字列化）で  
  `nico -> brainf*ck`のコード変換
- デバッグが用意
    - ~~にこ言語のコードを手書きするのはほぼムリなので、Brainf*ckからの変換が必要~~

- - - - -

## StateTモナド変換子で再代入を厳格管理
- 評価器をStateTモナド変換子で作った
- Haskellの真価の一つ
- よくOOPのバグの元となる、変数への再代入を型で管理できる
    - OOP: オブジェクト指向プログラミング
        - Object Oriented Programming

- - - - -

## MonadCatchで例外を管理
- safe-exceptionsのMonadCatchを使った
- これまたHaskellの魅力の一つ
    - 例外が起こるであろう箇所が~~そこそこ~~わかる
    - IO例外と  
      必要時評価による突然の例外はわからない

- - - - -

## GeneralizedNewTypeDerivingを使った

```haskell
-- The state of NicoMachine with the logging
newtype NicoState result = NicoState
  { _runNicoState :: WriterT [String] (StateT NicoMachine IO) result
  } deriving ( Functor, Applicative, Monad
             , MonadWriter [String], MonadState NicoMachine, MonadIO
             )
```

- **「「「モナドを合わせる能力」」」**
- `WriterT [String]`: ログが取れて
- `StateT NicoMachine`:  
  にこ言語用VMの状態のみ再代入を扱えて
- `IO`: 標準入出力（とか）をできる

- - - - -

## IOテストはyiエディタのテストを参考にした
- yi-keymap-vimのを参考にした
- [https://github.com/yi-editor/yi](https://github.com/yi-editor/yi)
    - Haskell製テキストエディタ
    - 最近ここに  
      Vimキーバインド関連でコントリビュートしてる

- - - - -

# おわり
# 👍

僕に聞きたいことあったらいつでも聞いて
- [@public_ai000ya](https://twitter.com/public_ai000ya) （Twitter）
