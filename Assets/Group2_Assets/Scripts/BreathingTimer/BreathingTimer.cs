using System.Collections;
using UnityEngine;
using TMPro;

public class BreathingTimer : MonoBehaviour
{
    public TextMeshProUGUI timerText;
    public float inhaleTime = 3f;
    public float exhaleTime = 7f;
    public Color inhaleColor = Color.blue;
    public Color exhaleColor = Color.green;
    private int cycleCount = 0;
    private int maxCycles = 3;

    private void Start()
    {
        gameObject.SetActive(false);
    }

    public void StartBreathingCycle()
    {
        gameObject.SetActive(true);
        cycleCount = 0;
        StartCoroutine(BreathingCycle());
    }

    private IEnumerator BreathingCycle()
    {
        while (cycleCount < maxCycles)
        {
            // Inhale
            timerText.color = inhaleColor;
            yield return StartCoroutine(StartTimer(inhaleTime));
            // Exhale
            timerText.color = exhaleColor;
            yield return StartCoroutine(StartTimer(exhaleTime));
            cycleCount++;
        }
        // Fade out timer
        StartCoroutine(FadeOutTimer());
    }

    private IEnumerator StartTimer(float duration)
    {
        float timer = duration;
        while (timer > 0)
        {
            timer -= Time.deltaTime;
            timerText.text = Mathf.Ceil(timer).ToString();
            yield return null;
        }
    }

    private IEnumerator FadeOutTimer()
    {
        CanvasGroup canvasGroup = GetComponent<CanvasGroup>();
        if (canvasGroup == null)
        {
            canvasGroup = gameObject.AddComponent<CanvasGroup>();
        }
        float fadeDuration = 1f;
        while (canvasGroup.alpha > 0)
        {
            canvasGroup.alpha -= Time.deltaTime / fadeDuration;
            yield return null;
        }
        gameObject.SetActive(false);
    }
}
