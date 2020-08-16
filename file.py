n1 = None
n2 = None

def text_prompt(msg):
  try:
    return raw_input(msg)
  except NameError:
    return input(msg)


n1 = float(text_prompt(''))
n2 = float(text_prompt(''))
print(n1 + n2)
