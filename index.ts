
export interface SignalListener extends Callback {}

export default class Signal<Args extends readonly unknown[] = unknown[]> {
    private _callbacks = new Set<SignalListener>;

    /**
     * Connects to the Signal
     * @returns Function
     */
    public Connect(handler: (...args: Args) => unknown): SignalListener {
        this._callbacks.add(handler);
        return handler;
    }

    /**
     * Fires the Signal with the given arguments. Must be in the same type as generic.
     */
    public Fire(...args: Args) {
        this._callbacks.forEach(callback => task.spawn(callback, ...args));
    }

    /**
     * Connects a listener and immediately disconnects it after connecting once.
     * @returns Function
     */
    public Once(handler: (...args: Args) => unknown): SignalListener {
        const f = this.Connect((...args) => {
            this.Unbind(f);
            handler(...args);
        });

        return f;
    }

    /**
     * Unbind callback from listener.
     */
    public Unbind(callback: SignalListener) {
        if (this._callbacks.has(callback))
            this._callbacks.delete(callback);
    }

    /**
     * Yield the current thread until signal gets fired.
     * @returns Signal Parameters
     */
    public Wait() : Args {
        const running = coroutine.running();
        
        this.Once((...args) => {
            task.spawn(running, ...args);
        });
        

        return coroutine.yield() as unknown as Args
    }

    /**
     * Unbinds all listeners.
     */
    public UnbindAll() {
        table.clear(this._callbacks);
    }

    /**
     * Destroy the signal.
     */
    public Destroy() {
        table.clear(this);
    }
}
