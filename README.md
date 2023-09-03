# Signal Class for Roblox TypeScript

This TypeScript class, `Signal`, provides a simple way to create and manage custom events and signals in Roblox using Roblox TypeScript (rbxts).

## Usage

### Creating a Signal

To create a new signal, simply import the `Signal` class and instantiate it. You can optionally specify the types of arguments that the signal will accept.

```typescript
import Signal from "./Signal";

const mySignal = new Signal<[message: string, value: number]>();
```

## Connecting to a Signal
You can connect functions or handlers to the signal using the `Connect` method. These functions will be called whenever the signal is fired.
```typescript
const myHandler = (message, value) => {
    print(`Received message: ${message}, Value: ${value}`);
};

mySignal.Connect(myHandler);
```

## Firing a Signal
To trigger the signal and call the connected handlers, use the `Fire` method. Provide arguments matching the types specified during signal creation.

```typescript
mySignal.Fire("Hello, World!", 42);
```

## Disconnecting from a Signal
You can disconnect a handler from a signal using the `Unbind` method. Pass the handler function you want to remove.

```typescript
mySignal.Unbind(myHandler);
```

## Disconnecting All Signals
To disconnect all handlers from a signal, use the UnbindAll method.

```typescript
mySignal.UnbindAll();
```

## Waiting for a Signal
You can yield the current thread until a signal is fired using the Wait method.

```typescript
const [message, value] = mySignal.Wait();
print(`Received message: ${message}, Value: ${value}`);
```

## Destroying a Signal
To clean up and destroy a signal, call the Destroy method.

```typescript
mySignal.Destroy();
```

# Example
Here's a complete example demonstrating the usage of the `Signal` class:
```typescript
import Signal from "./Signal";

// Create a new signal that accepts a string and a number
const mySignal = new Signal<[message: string, value: number]>();

// Connect a handler to the signal
const myHandler = (message, value) => {
    print(`Received message: ${message}, Value: ${value}`);
};

mySignal.Connect(myHandler);

// Trigger the signal
mySignal.Fire("Hello, World!", 42);

// Wait for the signal to be fired and print the received values
const [message, value] = mySignal.Wait();
print(`Received message: ${message}, Value: ${value}`);

// Disconnect the handler
mySignal.Unbind(myHandler);

// Destroy the signal when done
mySignal.Destroy();
```
